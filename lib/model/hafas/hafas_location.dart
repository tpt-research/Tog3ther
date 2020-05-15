import 'dart:convert';

class HafasLocation {
  Header header;
  String status;
  List<SuggestedLocation> suggestedLocations;
  List<Location> locations;

  HafasLocation({
    this.header,
    this.status,
    this.suggestedLocations,
    this.locations,
  });

  HafasLocation copyWith({
    Header header,
    String status,
    List<SuggestedLocation> suggestedLocations,
    List<Location> locations,
  }) =>
      HafasLocation(
        header: header ?? this.header,
        status: status ?? this.status,
        suggestedLocations: suggestedLocations ?? this.suggestedLocations,
        locations: locations ?? this.locations,
      );

  factory HafasLocation.fromRawJson(String str) => HafasLocation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HafasLocation.fromJson(Map<String, dynamic> json) => HafasLocation(
    header: json["header"] == null ? null : Header.fromJson(json["header"]),
    status: json["status"] == null ? null : json["status"],
    suggestedLocations: json["suggestedLocations"] == null ? null : List<SuggestedLocation>.from(json["suggestedLocations"].map((x) => SuggestedLocation.fromJson(x))),
    locations: json["locations"] == null ? null : List<Location>.from(json["locations"].map((x) => Location.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "header": header == null ? null : header.toJson(),
    "status": status == null ? null : status,
    "suggestedLocations": suggestedLocations == null ? null : List<dynamic>.from(suggestedLocations.map((x) => x.toJson())),
    "locations": locations == null ? null : List<dynamic>.from(locations.map((x) => x.toJson())),
  };
}

class Header {
  String network;
  String serverProduct;
  String serverVersion;
  dynamic serverName;
  int serverTime;
  dynamic context;

  Header({
    this.network,
    this.serverProduct,
    this.serverVersion,
    this.serverName,
    this.serverTime,
    this.context,
  });

  Header copyWith({
    String network,
    String serverProduct,
    String serverVersion,
    dynamic serverName,
    int serverTime,
    dynamic context,
  }) =>
      Header(
        network: network ?? this.network,
        serverProduct: serverProduct ?? this.serverProduct,
        serverVersion: serverVersion ?? this.serverVersion,
        serverName: serverName ?? this.serverName,
        serverTime: serverTime ?? this.serverTime,
        context: context ?? this.context,
      );

  factory Header.fromRawJson(String str) => Header.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Header.fromJson(Map<String, dynamic> json) => Header(
    network: json["network"] == null ? null : json["network"],
    serverProduct: json["serverProduct"] == null ? null : json["serverProduct"],
    serverVersion: json["serverVersion"] == null ? null : json["serverVersion"],
    serverName: json["serverName"],
    serverTime: json["serverTime"] == null ? null : json["serverTime"],
    context: json["context"],
  );

  Map<String, dynamic> toJson() => {
    "network": network == null ? null : network,
    "serverProduct": serverProduct == null ? null : serverProduct,
    "serverVersion": serverVersion == null ? null : serverVersion,
    "serverName": serverName,
    "serverTime": serverTime == null ? null : serverTime,
    "context": context,
  };
}

class Location {
  String type;
  String id;
  Map<String, double> coord;
  dynamic place;
  String name;
  List<String> products;
  int lonAs1E6;
  int latAs1E6;
  double latAsDouble;
  double lonAsDouble;
  bool identified;

  Location({
    this.type,
    this.id,
    this.coord,
    this.place,
    this.name,
    this.products,
    this.lonAs1E6,
    this.latAs1E6,
    this.latAsDouble,
    this.lonAsDouble,
    this.identified,
  });

  Location copyWith({
    String type,
    String id,
    Map<String, double> coord,
    dynamic place,
    String name,
    List<String> products,
    int lonAs1E6,
    int latAs1E6,
    double latAsDouble,
    double lonAsDouble,
    bool identified,
  }) =>
      Location(
        type: type ?? this.type,
        id: id ?? this.id,
        coord: coord ?? this.coord,
        place: place ?? this.place,
        name: name ?? this.name,
        products: products ?? this.products,
        lonAs1E6: lonAs1E6 ?? this.lonAs1E6,
        latAs1E6: latAs1E6 ?? this.latAs1E6,
        latAsDouble: latAsDouble ?? this.latAsDouble,
        lonAsDouble: lonAsDouble ?? this.lonAsDouble,
        identified: identified ?? this.identified,
      );

  factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"] == null ? null : json["type"],
    id: json["id"] == null ? null : json["id"],
    coord: json["coord"] == null ? null : Map.from(json["coord"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
    place: json["place"],
    name: json["name"] == null ? null : json["name"],
    products: json["products"] == null ? null : List<String>.from(json["products"].map((x) => x)),
    lonAs1E6: json["lonAs1E6"] == null ? null : json["lonAs1E6"],
    latAs1E6: json["latAs1E6"] == null ? null : json["latAs1E6"],
    latAsDouble: json["latAsDouble"] == null ? null : json["latAsDouble"].toDouble(),
    lonAsDouble: json["lonAsDouble"] == null ? null : json["lonAsDouble"].toDouble(),
    identified: json["identified"] == null ? null : json["identified"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "id": id == null ? null : id,
    "coord": coord == null ? null : Map.from(coord).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "place": place,
    "name": name == null ? null : name,
    "products": products == null ? null : List<dynamic>.from(products.map((x) => x)),
    "lonAs1E6": lonAs1E6 == null ? null : lonAs1E6,
    "latAs1E6": latAs1E6 == null ? null : latAs1E6,
    "latAsDouble": latAsDouble == null ? null : latAsDouble,
    "lonAsDouble": lonAsDouble == null ? null : lonAsDouble,
    "identified": identified == null ? null : identified,
  };
}

class SuggestedLocation {
  Location location;
  int priority;

  SuggestedLocation({
    this.location,
    this.priority,
  });

  SuggestedLocation copyWith({
    Location location,
    int priority,
  }) =>
      SuggestedLocation(
        location: location ?? this.location,
        priority: priority ?? this.priority,
      );

  factory SuggestedLocation.fromRawJson(String str) => SuggestedLocation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SuggestedLocation.fromJson(Map<String, dynamic> json) => SuggestedLocation(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    priority: json["priority"] == null ? null : json["priority"],
  );

  Map<String, dynamic> toJson() => {
    "location": location == null ? null : location.toJson(),
    "priority": priority == null ? null : priority,
  };
}
