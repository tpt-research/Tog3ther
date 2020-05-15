import 'dart:convert';

import '../EnumValues.dart';
import 'Departure.dart';
import 'Place.dart';
import 'SubTrip.dart';

class Trip {
  bool alternative;
  Departure arrival;
  Departure departure;
  Place from;
  List<String> information;
  List<SubTrip> routes;
  Place to;
  TripType tripType;

  Trip({
    this.alternative,
    this.arrival,
    this.departure,
    this.from,
    this.information,
    this.routes,
    this.to,
    this.tripType,
  });

  factory Trip.fromRawJson(String str) => Trip.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
    alternative: json["alternative"] == null ? null : json["alternative"],
    arrival: json["arrival"] == null ? null : Departure.fromJson(json["arrival"]),
    departure: json["departure"] == null ? null : Departure.fromJson(json["departure"]),
    from: json["from"] == null ? null : Place.fromJson(json["from"]),
    information: json["information"] == null ? null : List<String>.from(json["information"].map((x) => x)),
    routes: json["routes"] == null ? null : List<SubTrip>.from(json["routes"].map((x) => SubTrip.fromJson(x))),
    to: json["to"] == null ? null : Place.fromJson(json["to"]),
    tripType: json["tripType"] == null ? null : tripTypeValues.map[json["tripType"]],
  );

  Map<String, dynamic> toJson() => {
    "alternative": alternative == null ? null : alternative,
    "arrival": arrival == null ? null : arrival.toJson(),
    "departure": departure == null ? null : departure.toJson(),
    "from": from == null ? null : from.toJson(),
    "information": information == null ? null : List<dynamic>.from(information.map((x) => x)),
    "routes": routes == null ? null : List<dynamic>.from(routes.map((x) => x.toJson())),
    "to": to == null ? null : to.toJson(),
    "tripType": tripType == null ? null : tripTypeValues.reverse[tripType],
  };
}

enum TripType { MULTI_MODAL, SINGLE_MODAL }

final tripTypeValues = EnumValues({
  "multi_modal": TripType.MULTI_MODAL,
  "single_modal": TripType.SINGLE_MODAL
});
