import 'dart:convert';

class Departure {
  DateTime predictedTime;
  DateTime time;

  Departure({
    this.predictedTime,
    this.time,
  });

  factory Departure.fromRawJson(String str) => Departure.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Departure.fromJson(Map<String, dynamic> json) => Departure(
    predictedTime: json["predictedTime"] == null ? null : DateTime.parse(json["predictedTime"]),
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "predictedTime": predictedTime == null ? null : predictedTime.toIso8601String(),
    "time": time == null ? null : time.toIso8601String(),
  };
}
