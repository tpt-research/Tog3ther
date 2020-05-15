import 'dart:convert';

import '../EnumValues.dart';
import 'Location.dart';

class Place {
  bool available;
  bool barrierFree;
  String id;
  List<String> information;
  Location location;
  String name;
  PlaceType placeType;

  Place({
    this.available,
    this.barrierFree,
    this.id,
    this.information,
    this.location,
    this.name,
    this.placeType,
  });

  factory Place.fromRawJson(String str) => Place.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    available: json["available"] == null ? null : json["available"],
    barrierFree: json["barrier_free"] == null ? null : json["barrier_free"],
    id: json["id"] == null ? null : json["id"],
    information: json["information"] == null ? null : List<String>.from(json["information"].map((x) => x)),
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    name: json["name"] == null ? null : json["name"],
    placeType: json["placeType"] == null ? null : placeTypeValues.map[json["placeType"]],
  );

  Map<String, dynamic> toJson() => {
    "available": available == null ? null : available,
    "barrier_free": barrierFree == null ? null : barrierFree,
    "id": id == null ? null : id,
    "information": information == null ? null : List<dynamic>.from(information.map((x) => x)),
    "location": location == null ? null : location.toJson(),
    "name": name == null ? null : name,
    "placeType": placeType == null ? null : placeTypeValues.reverse[placeType],
  };
}

enum PlaceType { ADDRESS, AIRPORT, HARBOR, POI, STATION }

final placeTypeValues = EnumValues({
  "address": PlaceType.ADDRESS,
  "airport": PlaceType.AIRPORT,
  "harbor": PlaceType.HARBOR,
  "poi": PlaceType.POI,
  "station": PlaceType.STATION
});
