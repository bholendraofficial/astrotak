/*
 * Copyright (c) 2021. Bholendra Singh
 */

import 'dart:convert';

import 'package:astrotak/helper/app_helper.dart';
import 'package:astrotak/model/location_model.dart';
import 'package:astrotak/model/panchang_model.dart';
import 'package:astrotak/network/api_action.dart';
import 'package:astrotak/network/api_callback_listener.dart';
import 'package:astrotak/network/api_request.dart';
import 'package:astrotak/network/api_url.dart';
import 'package:astrotak/network/http_methods.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class PanchangDataProvider extends ChangeNotifier
    implements ApiCallBackListener {
  PanchangModel panchangModel = PanchangModel();
  Future<Data> future = Future.delayed(Duration.zero, () {
    return null;
  });

  TextEditingController locationEditingController = TextEditingController();
  LocationData selectedLocation;

  String selectedDateString = DateFormat("dd EEEE yyyy").format(DateTime.now());
  DateTime selectedDate = DateTime.now();

  getPanchangDataAPI(context) {
    future = null;
    Uri url = Uri(
      host: ApiUrl.host,
      scheme: ApiUrl.scheme,
      path: ApiUrl.panchang,
    );

    Map<String, String> body = {};
    body['day'] = selectedDate.day.toString();
    body['month'] = selectedDate.month.toString();
    body['year'] = selectedDate.year.toString();
    body['placeId'] = selectedLocation.placeId;

    ApiRequest(
        context: context,
        apiCallBackListener: this,
        showLoader: false,
        httpType: HttpMethods.POST,
        url: url.toString(),
        apiAction: ApiAction.panchang,
        body: body);
  }

  Future<List<LocationData>> getLocationDataAPI(context, inputPlace) async {
    Map<String, String> queryParameters = {};
    queryParameters['inputPlace'] = inputPlace;
    Uri url = Uri(
        host: ApiUrl.host,
        scheme: ApiUrl.scheme,
        path: ApiUrl.location,
        queryParameters: queryParameters);

    Request request = http.Request(HttpMethods.GET, url);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Map json =
          const JsonDecoder().convert(await response.stream.bytesToString());
      LocationModel locationModel = LocationModel.fromJson(json);
      if (locationModel.success) {
        return locationModel.data;
      }
    }
    return null;
  }

  @override
  apiCallBackListener(
      String action, int statusCode, Map<String, dynamic> json) {
    switch (action) {
      case ApiAction.panchang:
        {
          panchangModel = PanchangModel.fromJson(json);
          if (panchangModel.success) {
            future = Future.delayed(Duration.zero, () {
              return panchangModel.data;
            });
            notifyListeners();
          } else {
            AppHelper.showSnackBarMessage(panchangModel.message);
          }
          break;
        }
    }
  }

  showDatePickerDialog(context) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((date) {
      if (date != null) {
        selectedDate = date;
        selectedDateString = DateFormat("dd EEEE yyyy").format(date);
        if (selectedLocation != null && selectedDate != null) {
          getPanchangDataAPI(context);
        }
        notifyListeners();
      }
    });
  }
}
