/*
 * Copyright (c) 2021. Bholendra Singh
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:astrotak/helper/app_helper.dart';
import 'package:astrotak/helper/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'api_callback_listener.dart';
import 'http_methods.dart';
/* Created by Bholendra Singh  */

class ApiRequest {
  JsonDecoder jsonDecoder = const JsonDecoder();
  String url, action = "", httpType = "";
  Map<String, String> headers;
  Map<String, String> body;
  Map<String, dynamic> jsonResult;
  BuildContext context;
  Encoding encoding;
  Duration connectionTimeout = const Duration(minutes: 2);
  ApiCallBackListener apiCallBackListener;
  bool showLoader = true;
  bool isMultiPart = false;
  Map<String, File> mapOfFilesAndKey;

  ApiRequest(
      {@required BuildContext context,
      @required ApiCallBackListener apiCallBackListener,
      bool showLoader = true,
      @required String httpType,
      @required String url,
      @required String apiAction,
      Map<String, String> headers,
      Map<String, String> body,
      encoding,
      bool isMultiPart,
      Map<String, File> mapOfFilesAndKey}) {
    this.apiCallBackListener = apiCallBackListener;
    this.url = url;
    this.isMultiPart = isMultiPart;
    this.mapOfFilesAndKey = mapOfFilesAndKey;
    this.body = body;
    this.headers = headers;
    this.encoding = encoding;
    this.context = context;
    action = apiAction;
    this.httpType = httpType;
    this.showLoader = showLoader;
    if (context != null) {
      AppHelper.checkInternetConnectivity().then((bool isConnected) async {
        if (isConnected) {
          try {
            if (showLoader) {
              ProgressDialog.show(context);
            }
            headers = getApiHeader();
            if (isMultiPart != null && isMultiPart) {
              if (mapOfFilesAndKey != null) {
                getAPIMultiRequest(url,
                    headers: headers,
                    body: body,
                    encoding: encoding,
                    mapOfFilesAndKey: mapOfFilesAndKey);
              } else {
                getAPIMultiRequest(
                  url,
                  headers: headers,
                  body: body,
                  encoding: encoding,
                );
              }
            } else {
              getAPIRequest(url,
                  headers: headers, body: body, encoding: encoding);
            }
          } catch (onError) {
            debugPrint(onError.toString());
          }
        } else {
          AppHelper.showSnackBarMessage("No Internet Connection.");
        }
      });
    }
  }

  getAPIRequest(String url,
      {Map<String, String> headers, body, encoding}) async {
    debugPrint(
        "\n****************************API REQUEST************************************\n");
    debugPrint("\nApiRequest_url===" + url.toString());
    debugPrint("\nApiRequest_headers===" + headers.toString());
    debugPrint("\nApiRequest_body===" + body.toString());
    debugPrint(
        "\n****************************API REQUEST************************************\n");
    AppHelper.hideKeyBoard(context);
    Uri uri = Uri.parse(url);
    if (httpType == HttpMethods.GET) {
      return http
          .get(
            uri,
            headers: headers,
          )
          .then(httpResponse)
          .catchError(httpCatch)
          .timeout(connectionTimeout, onTimeout: () {
        apiTimeOut();
      });
    } else if (httpType == HttpMethods.POST) {
      return http
          .post(uri, headers: headers, body: jsonEncode(body))
          .then(httpResponse)
          .catchError(httpCatch)
          .timeout(connectionTimeout, onTimeout: () {
        apiTimeOut();
      });
    } else if (httpType == HttpMethods.PUT) {
      return http
          .put(uri, headers: headers, body: body)
          .then(httpResponse)
          .catchError(httpCatch)
          .timeout(connectionTimeout, onTimeout: () {
        apiTimeOut();
      });
    } else if (httpType == HttpMethods.DELETE) {
      return http
          .delete(uri, headers: headers)
          .then(httpResponse)
          .catchError(httpCatch)
          .timeout(connectionTimeout, onTimeout: () {
        apiTimeOut();
      });
    } else if (httpType == HttpMethods.PATCH) {
      return http
          .patch(uri, headers: headers, body: body)
          .then(httpResponse)
          .catchError(httpCatch)
          .timeout(connectionTimeout, onTimeout: () {
        apiTimeOut();
      });
    }
  }

  httpCatch(onError) {
    if (showLoader) {
      ProgressDialog.hide();
    }
    debugPrint("httpCatch===" + onError.toString());
    AppHelper.showSnackBarMessage(
        "Oops! Something went wrong.\n" + onError.toString());
  }

  FutureOr httpResponse(Response response) {
    try {
      if (showLoader) {
        ProgressDialog.hide();
      }
      var res = response.body;
      var statusCode = response.statusCode;

      debugPrint(
          "\n****************************API RESPONSE************************************\n");

      debugPrint("\n\nApiRequest_HTTP_RESPONSE===" + res.toString());
      debugPrint("\n\nApiRequest_HTTP_BODY_RESPONSE===" + res);
      debugPrint(
          "\n\nApiRequest_HTTP_RESPONSE_CODE===" + statusCode.toString());

      debugPrint(
          "\n****************************API RESPONSE************************************\n");
      jsonResult = jsonDecoder.convert(res);
      if (jsonResult != null) {
        debugPrint("success===" + jsonResult.toString());
        return apiCallBackListener.apiCallBackListener(
            action, statusCode, jsonResult);
      } else {
        if (jsonResult != null && jsonResult['message'] != null) {
          AppHelper.showSnackBarMessage(jsonResult['message'].toString());
        }
      }
    } catch (onError) {
      httpCatch(onError);
    }
  }

  Future<FutureOr> httpResponseString(http.StreamedResponse response) async {
    try {
      if (showLoader) {
        ProgressDialog.hide();
      }
      var res = await response.stream.bytesToString();
      var statusCode = response.statusCode;
      jsonResult = jsonDecoder.convert(res);

      debugPrint(
          "\n****************************API RESPONSE************************************\n");

      debugPrint("\n\nApiRequest_HTTP_RESPONSE===" + jsonResult.toString());
      debugPrint("\n\nApiRequest_HTTP_BODY_RESPONSE===" + res);
      debugPrint(
          "\n\nApiRequest_HTTP_RESPONSE_CODE===" + statusCode.toString());

      debugPrint(
          "\n****************************API RESPONSE************************************\n");

      if (jsonResult != null) {
        debugPrint("success===" + jsonResult.toString());
        return apiCallBackListener.apiCallBackListener(
            action, statusCode, jsonResult);
      } else {
        if (jsonResult != null && jsonResult['message'] != null) {
          AppHelper.showSnackBarMessage(jsonResult['message'].toString());
        }
      }
    } catch (onError) {
      httpCatch(onError);
    }
  }

  apiTimeOut() {
    if (showLoader) {
      ProgressDialog.hide();
    }
    debugPrint('Please try again .');
    AppHelper.showSnackBarMessage("Connection timeout Please try again...");
  }

  Map<String, String> getApiHeader() {
    return {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
  }

  Future getAPIMultiRequest(String url,
      {Map<String, String> headers,
      body,
      encoding,
      Map<String, File> mapOfFilesAndKey}) async {
    debugPrint(
        "\n****************************API REQUEST************************************\n");
    debugPrint("\nApiRequest_url===" + url.toString());
    debugPrint("\nApiRequest_headers===" + headers.toString());
    debugPrint("\nApiRequest_body===" + body.toString());
    debugPrint(
        "\n****************************API REQUEST************************************\n");
    var uri = Uri.parse(url);
    var request = MultipartRequest(httpType, uri);

    List<String> keysForImage = [];
    if (mapOfFilesAndKey != null) {
      for (int i = 0; i < mapOfFilesAndKey.length; i++) {
        String key = mapOfFilesAndKey.keys.elementAt(i);
        keysForImage.add(key);
      }
    }

    if (body != null) {
      for (int i = 0; i < body.length; i++) {
        String key = body.keys.elementAt(i);
        request.fields[key] = body[key];
      }
    }

    for (int i = 0; i < keysForImage.length; i++) {
      var multipartFile = await MultipartFile.fromPath(
          keysForImage[i], mapOfFilesAndKey[keysForImage[i]].path);
      request.files.add(multipartFile);
    }
    request.headers.addAll(headers);

    http.Response.fromStream(await request.send())
        .then(httpResponse)
        .catchError(httpCatch)
        .timeout(connectionTimeout, onTimeout: () {
      apiTimeOut();
    });
  }
}
