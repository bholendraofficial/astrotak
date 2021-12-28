/*
 * Copyright (c) 2021. Bholendra Singh
 */

import 'package:astrotak/helper/app_helper.dart';
import 'package:astrotak/model/sort_model.dart';
import 'package:astrotak/model/astrologer_model.dart';
import 'package:astrotak/network/api_action.dart';
import 'package:astrotak/network/api_callback_listener.dart';
import 'package:astrotak/network/api_request.dart';
import 'package:astrotak/network/api_url.dart';
import 'package:astrotak/network/http_methods.dart';
import 'package:flutter/foundation.dart';

class AstrologerDataProvider extends ChangeNotifier
    implements ApiCallBackListener {
  AstrologerModel astrologerModel = AstrologerModel();
  Future<List<Data>> future;
  bool showSearchBar = false;

  List<SortModel> sortList = [
    SortModel(
        id: 0,
        name: "Experience- high to high",
        isSelected: false,
        sorting: Sorting.EX_HIGH_TO_LOW),
    SortModel(
        id: 1,
        name: "Experience- low to high",
        isSelected: false,
        sorting: Sorting.EX_LOW_TO_HIGH),
    SortModel(
        id: 2,
        name: "Price- high to low",
        isSelected: false,
        sorting: Sorting.PRICE_HIGH_TO_LOW),
    SortModel(
        id: 3,
        name: "Price- low to high",
        isSelected: false,
        sorting: Sorting.PRICE_LOW_TO_HIGH),
  ];

  getAstroDataAPI(context) {
    future = null;
    Uri url = Uri(
      host: ApiUrl.host,
      scheme: ApiUrl.scheme,
      path: ApiUrl.astroapi,
    );
    ApiRequest(
      context: context,
      apiCallBackListener: this,
      showLoader: false,
      httpType: HttpMethods.GET,
      url: url.toString(),
      apiAction: ApiAction.astroapi,
    );
  }

  @override
  apiCallBackListener(
      String action, int statusCode, Map<String, dynamic> json) {
    switch (action) {
      case ApiAction.astroapi:
        {
          astrologerModel = AstrologerModel.fromJson(json);
          if (astrologerModel.success) {
            future = Future.delayed(Duration.zero, () {
              return astrologerModel.data;
            });
            notifyListeners();
          } else {
            AppHelper.showSnackBarMessage(astrologerModel.message);
          }
          break;
        }
    }
  }

  void onSearch(String value) {
    List<Data> data = [];
    for (var element in astrologerModel.data) {
      if (element.firstName.toLowerCase().contains(value.toLowerCase()) ||
          element.lastName.toLowerCase().contains(value.toLowerCase())) {
        data.add(element);
      }
    }
    future = Future.delayed(Duration.zero, () {
      return data;
    });
    notifyListeners();
  }

  void clearSearch() {
    showSearchBar = false;
    future = Future.delayed(Duration.zero, () {
      return astrologerModel.data;
    });
    notifyListeners();
  }

  void sortData(SortModel sortModel) {
    for (var element in sortList) {
      if (element.id == sortModel.id) {
        element.isSelected = !element.isSelected;
      } else {
        element.isSelected = false;
      }
    }

    if (sortModel.isSelected) {
      List<Data> data = astrologerModel.data.toList();
      Comparator<Data> priceComparator;
      switch (sortModel.sorting) {
        case Sorting.EX_HIGH_TO_LOW:
          priceComparator = (a, b) => b.experience.compareTo(a.experience);
          break;
        case Sorting.EX_LOW_TO_HIGH:
          priceComparator = (a, b) => a.experience.compareTo(b.experience);
          break;
        case Sorting.PRICE_HIGH_TO_LOW:
          priceComparator = (a, b) => b.minimumCallDurationCharges
              .compareTo(a.minimumCallDurationCharges);
          break;
        case Sorting.PRICE_LOW_TO_HIGH:
          priceComparator = (a, b) => a.minimumCallDurationCharges
              .compareTo(b.minimumCallDurationCharges);
          break;
      }
      data.sort(priceComparator);
      future = Future.delayed(Duration.zero, () {
        return data;
      });
    } else {
      future = Future.delayed(Duration.zero, () {
        return astrologerModel.data;
      });
    }
    notifyListeners();
  }
}
