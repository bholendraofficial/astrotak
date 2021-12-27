class AstrologerModel {
  String httpStatus;
  int httpStatusCode;
  bool success;
  String message;
  String apiName;
  List<Data> data;

  AstrologerModel(
      {this.httpStatus,
      this.httpStatusCode,
      this.success,
      this.message,
      this.apiName,
      this.data});

  AstrologerModel.fromJson(Map<String, dynamic> json) {
    httpStatus = json['httpStatus'];
    httpStatusCode = json['httpStatusCode'];
    success = json['success'];
    message = json['message'];
    apiName = json['apiName'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
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

class Data {
  int id;
  String urlSlug;
  String namePrefix;
  String firstName;
  String lastName;
  String aboutMe;
  dynamic profliePicUrl;
  double experience;
  List<Languages> languages;
  dynamic minimumCallDuration;
  dynamic minimumCallDurationCharges;
  dynamic additionalPerMinuteCharges;
  bool isAvailable;
  double rating;
  List<Skills> skills;
  bool isOnCall;
  dynamic freeMinutes;
  dynamic additionalMinute;
  Images images;
  Availability availability;

  Data(
      {this.id,
      this.urlSlug,
      this.namePrefix,
      this.firstName,
      this.lastName,
      this.aboutMe,
      this.profliePicUrl,
      this.experience,
      this.languages,
      this.minimumCallDuration,
      this.minimumCallDurationCharges,
      this.additionalPerMinuteCharges,
      this.isAvailable,
      this.rating,
      this.skills,
      this.isOnCall,
      this.freeMinutes,
      this.additionalMinute,
      this.images,
      this.availability});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urlSlug = json['urlSlug'];
    namePrefix = json['namePrefix'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    aboutMe = json['aboutMe'];
    profliePicUrl = json['profliePicUrl'];
    experience = json['experience'] != null
        ? double.tryParse(json['experience'].toString())
        : null;
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages.add(Languages.fromJson(v));
      });
    }
    minimumCallDuration = json['minimumCallDuration'];
    minimumCallDurationCharges = json['minimumCallDurationCharges'];
    additionalPerMinuteCharges = json['additionalPerMinuteCharges'];
    isAvailable = json['isAvailable'];
    rating = json['rating'];
    if (json['skills'] != null) {
      skills = <Skills>[];
      json['skills'].forEach((v) {
        skills.add(Skills.fromJson(v));
      });
    }
    isOnCall = json['isOnCall'];
    freeMinutes = json['freeMinutes'];
    additionalMinute = json['additionalMinute'];
    images = json['images'] != null ? Images.fromJson(json['images']) : null;
    availability = json['availability'] != null
        ? Availability.fromJson(json['availability'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['urlSlug'] = urlSlug;
    data['namePrefix'] = namePrefix;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['aboutMe'] = aboutMe;
    data['profliePicUrl'] = profliePicUrl;
    data['experience'] = experience;
    if (languages != null) {
      data['languages'] = languages.map((v) => v.toJson()).toList();
    }
    data['minimumCallDuration'] = minimumCallDuration;
    data['minimumCallDurationCharges'] = minimumCallDurationCharges;
    data['additionalPerMinuteCharges'] = additionalPerMinuteCharges;
    data['isAvailable'] = isAvailable;
    data['rating'] = rating;
    if (skills != null) {
      data['skills'] = skills.map((v) => v.toJson()).toList();
    }
    data['isOnCall'] = isOnCall;
    data['freeMinutes'] = freeMinutes;
    data['additionalMinute'] = additionalMinute;
    if (images != null) {
      data['images'] = images.toJson();
    }
    if (availability != null) {
      data['availability'] = availability.toJson();
    }
    return data;
  }
}

class Languages {
  int id;
  String name;

  Languages({this.id, this.name});

  Languages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Skills {
  int id;
  String name;
  String description;

  Skills({this.id, this.name, this.description});

  Skills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}

class Images {
  Small small;
  Large large;
  Large medium;

  Images({this.small, this.large, this.medium});

  Images.fromJson(Map<String, dynamic> json) {
    small = json['small'] != null ? Small.fromJson(json['small']) : null;
    large = json['large'] != null ? Large.fromJson(json['large']) : null;
    medium = json['medium'] != null ? Large.fromJson(json['medium']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (small != null) {
      data['small'] = small.toJson();
    }
    if (large != null) {
      data['large'] = large.toJson();
    }
    if (medium != null) {
      data['medium'] = medium.toJson();
    }
    return data;
  }
}

class Small {
  dynamic imageUrl;
  dynamic id;

  Small({this.imageUrl, this.id});

  Small.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    data['id'] = id;
    return data;
  }
}

class Large {
  String imageUrl;
  int id;

  Large({this.imageUrl, this.id});

  Large.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    data['id'] = id;
    return data;
  }
}

class Availability {
  List<String> days;
  Slot slot;

  Availability({this.days, this.slot});

  Availability.fromJson(Map<String, dynamic> json) {
    days = json['days'].cast<String>();
    slot = json['slot'] != null ? Slot.fromJson(json['slot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['days'] = days;
    if (slot != null) {
      data['slot'] = slot.toJson();
    }
    return data;
  }
}

class Slot {
  String toFormat;
  String fromFormat;
  String from;
  String to;

  Slot({this.toFormat, this.fromFormat, this.from, this.to});

  Slot.fromJson(Map<String, dynamic> json) {
    toFormat = json['toFormat'];
    fromFormat = json['fromFormat'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['toFormat'] = toFormat;
    data['fromFormat'] = fromFormat;
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}
