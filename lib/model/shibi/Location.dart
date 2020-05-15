import 'dart:convert';

class Location {
  double altitude;
  double latitude;
  double longitude;

  Location({
    this.altitude,
    this.latitude,
    this.longitude,
  });

  factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    altitude: json["altitude"] == null ? null : json["altitude"].toDouble(),
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "altitude": altitude == null ? null : altitude,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
  };
}
