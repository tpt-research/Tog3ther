import 'dart:convert';

import 'Place.dart';
import 'Trip.dart';

class Shibi {
  String context;
  Place from;
  double serverResponseTime;
  Place to;
  List<Trip> trips;

  Shibi({
    this.context,
    this.from,
    this.serverResponseTime,
    this.to,
    this.trips,
  });

  factory Shibi.fromRawJson(String str) => Shibi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Shibi.fromJson(Map<String, dynamic> json) => Shibi(
    context: json["context"] == null ? null : json["context"],
    from: json["from"] == null ? null : Place.fromJson(json["from"]),
    serverResponseTime: json["serverResponseTime"] == null ? null : json["serverResponseTime"].toDouble(),
    to: json["to"] == null ? null : Place.fromJson(json["to"]),
    trips: json["trips"] == null ? null : List<Trip>.from(json["trips"].map((x) => Trip.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "context": context == null ? null : context,
    "from": from == null ? null : from.toJson(),
    "serverResponseTime": serverResponseTime == null ? null : serverResponseTime,
    "to": to == null ? null : to.toJson(),
    "trips": trips == null ? null : List<dynamic>.from(trips.map((x) => x.toJson())),
  };
}
