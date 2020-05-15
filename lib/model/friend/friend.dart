import 'dart:convert';

import 'package:tog3ther/model/geojson/geojson.dart';

class Friend {
  int friendCount;
  List<FriendElement> friends;

  Friend({
    this.friendCount,
    this.friends,
  });

  Friend copyWith({
    int friendCount,
    List<FriendElement> friends,
  }) =>
      Friend(
        friendCount: friendCount ?? this.friendCount,
        friends: friends ?? this.friends,
      );

  factory Friend.fromRawJson(String str) => Friend.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
    friendCount: json["friendCount"] == null ? null : json["friendCount"],
    friends: json["friends"] == null ? null : List<FriendElement>.from(json["friends"].map((x) => FriendElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "friendCount": friendCount == null ? null : friendCount,
    "friends": friends == null ? null : List<dynamic>.from(friends.map((x) => x.toJson())),
  };
}

class FriendElement {
  String name;
  int iconCodepoint;
  int color;
  Feature feature;
  String id;

  FriendElement({
    this.name,
    this.iconCodepoint,
    this.color,
    this.feature,
    this.id
  });

  FriendElement copyWith({
    String name,
    int iconCodepoint,
    int color,
    Feature feature,
    String id
  }) =>
      FriendElement(
        name: name ?? this.name,
        iconCodepoint: iconCodepoint ?? this.iconCodepoint,
        color: color ?? this.color,
        feature: feature ?? this.feature,
        id: id ?? this.id,
      );

  factory FriendElement.fromRawJson(String str) => FriendElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FriendElement.fromJson(Map<String, dynamic> json) => FriendElement(
    name: json["name"] == null ? null : json["name"],
    iconCodepoint: json["iconCodepoint"] == null ? null : json["iconCodepoint"],
    color: json["color"] == null ? null : json["color"],
    feature: json["feature"] == null ? null : Feature.fromJson(json["feature"]),
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "iconCodepoint": iconCodepoint == null ? null : iconCodepoint,
    "color": color == null ? null : color,
    "feature": feature == null ? null : feature.toJson(),
    "id": id == null ? null : id,
  };
}
