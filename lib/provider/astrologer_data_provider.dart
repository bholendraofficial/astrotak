import 'dart:io';

import 'package:astrotak/helper/app_helper.dart';
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
}
