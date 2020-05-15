import 'dart:convert';

import '../EnumValues.dart';

class Vehicle {
  bool barrierFree;
  VehicleClimateFootprint climateFootprint;
  List<VehicleFeatures> features;
  String id;
  String name;
  String vehicleOperator;
  double seats;
  VehicleSpeed speed;
  VehicleType vehicleType;

  Vehicle({
    this.barrierFree,
    this.climateFootprint,
    this.features,
    this.id,
    this.name,
    this.vehicleOperator,
    this.seats,
    this.speed,
    this.vehicleType,
  });

  factory Vehicle.fromRawJson(String str) => Vehicle.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    barrierFree: json["barrier_free"] == null ? null : json["barrier_free"],
    climateFootprint: json["climateFootprint"] == null ? null : vehicleClimateFootprintValues.map[json["climateFootprint"]],
    features: json["features"] == null ? null : List<VehicleFeatures>.from(json["features"].map((x) => vehicleFeaturesValues.map[x])),
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    vehicleOperator: json["operator"] == null ? null : json["operator"],
    seats: json["seats"] == null ? null : json["seats"].toDouble(),
    speed: json["speed"] == null ? null : vehicleSpeedValues.map[json["speed"]],
    vehicleType: json["vehicleType"] == null ? null : vehicleTypeValues.map[json["vehicleType"]],
  );

  Map<String, dynamic> toJson() => {
    "barrier_free": barrierFree == null ? null : barrierFree,
    "climateFootprint": climateFootprint == null ? null : vehicleClimateFootprintValues.reverse[climateFootprint],
    "features": features == null ? null : List<dynamic>.from(features.map((x) => vehicleFeaturesValues.reverse[x])),
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "operator": vehicleOperator == null ? null : vehicleOperator,
    "seats": seats == null ? null : seats,
    "speed": speed == null ? null : vehicleSpeedValues.reverse[speed],
    "vehicleType": vehicleType == null ? null : vehicleTypeValues.reverse[vehicleType],
  };
}

enum VehicleClimateFootprint { HIGH, LOW, MEDIUM, NEUTRAL, VERY_HIGH, VERY_LOW }

final vehicleClimateFootprintValues = EnumValues({
  "high": VehicleClimateFootprint.HIGH,
  "low": VehicleClimateFootprint.LOW,
  "medium": VehicleClimateFootprint.MEDIUM,
  "neutral": VehicleClimateFootprint.NEUTRAL,
  "very_high": VehicleClimateFootprint.VERY_HIGH,
  "very_low": VehicleClimateFootprint.VERY_LOW
});

enum VehicleFeatures { FAMILY_FRIENDLY, HUMAN_SUPPORT, PANORAMA, POWER_SOCKETS, RESTAURANT, TICKET_MACHINES, TOILETS, WIFI }

final vehicleFeaturesValues = EnumValues({
  "family_friendly": VehicleFeatures.FAMILY_FRIENDLY,
  "human_support": VehicleFeatures.HUMAN_SUPPORT,
  "panorama": VehicleFeatures.PANORAMA,
  "power_sockets": VehicleFeatures.POWER_SOCKETS,
  "restaurant": VehicleFeatures.RESTAURANT,
  "ticket_machines": VehicleFeatures.TICKET_MACHINES,
  "toilets": VehicleFeatures.TOILETS,
  "wifi": VehicleFeatures.WIFI
});

enum VehicleSpeed { FAST, NORMAL, SLOW, VERY_FAST, VERY_SLOW }

final vehicleSpeedValues = EnumValues({
  "fast": VehicleSpeed.FAST,
  "normal": VehicleSpeed.NORMAL,
  "slow": VehicleSpeed.SLOW,
  "very_fast": VehicleSpeed.VERY_FAST,
  "very_slow": VehicleSpeed.VERY_SLOW
});

enum VehicleType { AIRPLANE, BIKE, BUS, CABLEWAY, CAR, CARSHARING, ESCOOTER, FERRY, MISC, ONDEMAND, RIDESHARING, ROCKET, SHIP, SUBWAY, TAXI, TELEPORTER, TRAIN, TRAM, TRANSRAPID }

final vehicleTypeValues = EnumValues({
  "airplane": VehicleType.AIRPLANE,
  "bike": VehicleType.BIKE,
  "bus": VehicleType.BUS,
  "cableway": VehicleType.CABLEWAY,
  "car": VehicleType.CAR,
  "carsharing": VehicleType.CARSHARING,
  "escooter": VehicleType.ESCOOTER,
  "ferry": VehicleType.FERRY,
  "misc": VehicleType.MISC,
  "ondemand": VehicleType.ONDEMAND,
  "ridesharing": VehicleType.RIDESHARING,
  "rocket": VehicleType.ROCKET,
  "ship": VehicleType.SHIP,
  "subway": VehicleType.SUBWAY,
  "taxi": VehicleType.TAXI,
  "teleporter": VehicleType.TELEPORTER,
  "train": VehicleType.TRAIN,
  "tram": VehicleType.TRAM,
  "transrapid": VehicleType.TRANSRAPID
});
