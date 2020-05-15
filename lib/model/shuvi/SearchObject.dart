import 'dart:convert';

import 'package:flutter/material.dart';

class SearchObject {
  double latitude;
  double longitude;
  String name;

  SearchObject({
    @required this.latitude,
    @required this.longitude,
    @required this.name,
  });

  factory SearchObject.fromRawJson(String str) => SearchObject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchObject.fromJson(Map<String, dynamic> json) => SearchObject(
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "name": name == null ? null : name,
  };
}
