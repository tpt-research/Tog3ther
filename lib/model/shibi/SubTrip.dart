import 'dart:convert';

import 'Departure.dart';
import 'Place.dart';
import 'Vehicle.dart';

class SubTrip {
  Departure arrival;
  Departure departure;
  Place from;
  String information;
  String source;
  List<Place> stops;
  Place to;
  String fromTrack;
  String toTrack;
  String url;
  Vehicle vehicle;

  SubTrip({
    this.arrival,
    this.departure,
    this.from,
    this.information,
    this.source,
    this.stops,
    this.to,
    this.fromTrack,
    this.toTrack,
    this.url,
    this.vehicle,
  });

  factory SubTrip.fromRawJson(String str) => SubTrip.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubTrip.fromJson(Map<String, dynamic> json) => SubTrip(
    arrival: json["arrival"] == null ? null : Departure.fromJson(json["arrival"]),
    departure: json["departure"] == null ? null : Departure.fromJson(json["departure"]),
    from: json["from"] == null ? null : Place.fromJson(json["from"]),
    information: json["information"] == null ? null : json["information"],
    source: json["source"] == null ? null : json["source"],
    stops: json["stops"] == null ? null : List<Place>.from(json["stops"].map((x) => Place.fromJson(x))),
    to: json["to"] == null ? null : Place.fromJson(json["to"]),
    fromTrack: json["fromTrack"] == null ? null : json["fromTrack"],
    toTrack: json["toTrack"] == null ? null : json["toTrack"],
    url: json["url"] == null ? null : json["url"],
    vehicle: json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
  );

  Map<String, dynamic> toJson() => {
    "arrival": arrival == null ? null : arrival.toJson(),
    "departure": departure == null ? null : departure.toJson(),
    "from": from == null ? null : from.toJson(),
    "information": information == null ? null : information,
    "source": source == null ? null : source,
    "stops": stops == null ? null : List<dynamic>.from(stops.map((x) => x.toJson())),
    "to": to == null ? null : to.toJson(),
    "fromTrack": fromTrack == null ? null : fromTrack,
    "toTrack": toTrack == null ? null : toTrack,
    "url": url == null ? null : url,
    "vehicle": vehicle == null ? null : vehicle.toJson(),
  };
}
