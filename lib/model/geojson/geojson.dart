import 'dart:convert';

class GeoJSON {
  List<Feature> features;
  String type;

  GeoJSON({
    this.features,
    this.type,
  });

  GeoJSON copyWith({
    List<Feature> features,
    String type,
  }) =>
      GeoJSON(
        features: features ?? this.features,
        type: type ?? this.type,
      );

  factory GeoJSON.fromRawJson(String str) => GeoJSON.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeoJSON.fromJson(Map<String, dynamic> json) => GeoJSON(
    features: json["features"] == null ? null : List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "features": features == null ? null : List<dynamic>.from(features.map((x) => x.toJson())),
    "type": type == null ? null : type,
  };
}

class Feature {
  Geometry geometry;
  String type;
  Properties properties;

  Feature({
    this.geometry,
    this.type,
    this.properties,
  });

  Feature copyWith({
    Geometry geometry,
    String type,
    Properties properties,
  }) =>
      Feature(
        geometry: geometry ?? this.geometry,
        type: type ?? this.type,
        properties: properties ?? this.properties,
      );

  factory Feature.fromRawJson(String str) => Feature.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
    type: json["type"] == null ? null : json["type"],
    properties: json["properties"] == null ? null : Properties.fromJson(json["properties"]),
  );

  Map<String, dynamic> toJson() => {
    "geometry": geometry == null ? null : geometry.toJson(),
    "type": type == null ? null : type,
    "properties": properties == null ? null : properties.toJson(),
  };
}

class Geometry {
  List<double> coordinates;
  String type;

  Geometry({
    this.coordinates,
    this.type,
  });

  Geometry copyWith({
    List<double> coordinates,
    String type,
  }) =>
      Geometry(
        coordinates: coordinates ?? this.coordinates,
        type: type ?? this.type,
      );

  factory Geometry.fromRawJson(String str) => Geometry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    coordinates: json["coordinates"] == null ? null : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates.map((x) => x)),
    "type": type == null ? null : type,
  };
}

class Properties {
  int osmId;
  String osmType;
  String country;
  String osmKey;
  String city;
  String osmValue;
  String postcode;
  String name;
  String state;
  List<double> extent;
  String street;
  String housenumber;

  Properties({
    this.osmId,
    this.osmType,
    this.country,
    this.osmKey,
    this.city,
    this.osmValue,
    this.postcode,
    this.name,
    this.state,
    this.extent,
    this.street,
    this.housenumber,
  });

  Properties copyWith({
    int osmId,
    String osmType,
    String country,
    String osmKey,
    String city,
    String osmValue,
    String postcode,
    String name,
    String state,
    List<double> extent,
    String street,
    String housenumber,
  }) =>
      Properties(
        osmId: osmId ?? this.osmId,
        osmType: osmType ?? this.osmType,
        country: country ?? this.country,
        osmKey: osmKey ?? this.osmKey,
        city: city ?? this.city,
        osmValue: osmValue ?? this.osmValue,
        postcode: postcode ?? this.postcode,
        name: name ?? this.name,
        state: state ?? this.state,
        extent: extent ?? this.extent,
        street: street ?? this.street,
        housenumber: housenumber ?? this.housenumber,
      );

  factory Properties.fromRawJson(String str) => Properties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    osmId: json["osm_id"] == null ? null : json["osm_id"],
    osmType: json["osm_type"] == null ? null : json["osm_type"],
    country: json["country"] == null ? null : json["country"],
    osmKey: json["osm_key"] == null ? null : json["osm_key"],
    city: json["city"] == null ? null : json["city"],
    osmValue: json["osm_value"] == null ? null : json["osm_value"],
    postcode: json["postcode"] == null ? null : json["postcode"],
    name: json["name"] == null ? null : json["name"],
    state: json["state"] == null ? null : json["state"],
    extent: json["extent"] == null ? null : List<double>.from(json["extent"].map((x) => x.toDouble())),
    street: json["street"] == null ? null : json["street"],
    housenumber: json["housenumber"] == null ? null : json["housenumber"],
  );

  Map<String, dynamic> toJson() => {
    "osm_id": osmId == null ? null : osmId,
    "osm_type": osmType == null ? null : osmType,
    "country": country == null ? null : country,
    "osm_key": osmKey == null ? null : osmKey,
    "city": city == null ? null : city,
    "osm_value": osmValue == null ? null : osmValue,
    "postcode": postcode == null ? null : postcode,
    "name": name == null ? null : name,
    "state": state == null ? null : state,
    "extent": extent == null ? null : List<dynamic>.from(extent.map((x) => x)),
    "street": street == null ? null : street,
    "housenumber": housenumber == null ? null : housenumber,
  };
}
