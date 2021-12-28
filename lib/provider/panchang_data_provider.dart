import 'dart:convert';
import 'dart:io';

import 'package:astrotak/helper/app_helper.dart';
import 'package:astrotak/model/SortModel.dart';
import 'package:astrotak/model/panchang_model.dart';
import 'package:astrotak/network/api_action.dart';
import 'package:astrotak/network/api_callback_listener.dart';
import 'package:astrotak/network/api_request.dart';
import 'package:astrotak/network/api_url.dart';
import 'package:astrotak/network/http_methods.dart';
import 'package:flutter/foundation.dart';

class PanchangDataProvider extends ChangeNotifier
    implements ApiCallBackListener {
  PanchangModel panchangModel = PanchangModel();
  Future<Data> future;

  getPanchangDataAPI(context) {
    future = null;
    Uri url = Uri(
      host: ApiUrl.host,
      scheme: ApiUrl.scheme,
      path: ApiUrl.panchang,
    );

    Map<String, String> body = {};
    body['day'] = '2';
    body['month'] = '7';
    body['year'] = '2021';
    body['placeId'] = 'ChIJL_P_CXMEDTkRw0ZdG-0GVvw';

    ApiRequest(
        context: context,
        apiCallBackListener: this,
        showLoader: false,
        httpType: HttpMethods.POST,
        url: url.toString(),
        apiAction: ApiAction.panchang,
        body: body);
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
}
