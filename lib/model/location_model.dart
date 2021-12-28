/*
 * Copyright (c) 2021. Bholendra Singh
 */

class LocationModel {
  String httpStatus;
  int httpStatusCode;
  bool success;
  String message;
  String apiName;
  List<LocationData> data;

  LocationModel(
      {this.httpStatus,
      this.httpStatusCode,
      this.success,
      this.message,
      this.apiName,
      this.data});

  LocationModel.fromJson(Map<String, dynamic> json) {
    httpStatus = json['httpStatus'];
    httpStatusCode = json['httpStatusCode'];
    success = json['success'];
    message = json['message'];
    apiName = json['apiName'];
    if (json['data'] != null) {
      data = <LocationData>[];
      json['data'].forEach((v) {
        data.add(LocationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['httpStatus'] = httpStatus;
    data['httpStatusCode'] = httpStatusCode;
    data['success'] = success;
    data['message'] = message;
    data['apiName'] = apiName;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocationData {
  String placeName;
  String placeId;

  LocationData({this.placeName, this.placeId});

  LocationData.fromJson(Map<String, dynamic> json) {
    placeName = json['placeName'];
    placeId = json['placeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['placeName'] = placeName;
    data['placeId'] = placeId;
    return data;
  }
}
