import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tog3ther/model/shuvi/SearchObject.dart';

import '../EnumValues.dart';

class SearchCluster {
  String date;
  SearchObject from;
  List<Source> sources;
  SearchObject to;

  SearchCluster({
    @required this.date,
    @required this.from,
    @required this.sources,
    @required this.to,
  });

  factory SearchCluster.fromRawJson(String str) => SearchCluster.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchCluster.fromJson(Map<String, dynamic> json) => SearchCluster(
    date: json["date"] == null ? null : json["date"],
    from: json["from"] == null ? null : SearchObject.fromJson(json["from"]),
    sources: json["sources"] == null ? null : List<Source>.from(json["sources"].map((x) => sourceValues.map[x])),
    to: json["to"] == null ? null : SearchObject.fromJson(json["to"]),
  );

  Map<String, dynamic> toJson() => {
    "date": date == null ? null : date,
    "from": from == null ? null : from.toJson(),
    "sources": sources == null ? null : List<dynamic>.from(sources.map((x) => sourceValues.reverse[x])),
    "to": to == null ? null : to.toJson(),
  };
}

enum Source { FLIXBUS, DEUTSCHEBAHN, RMV, BVG, OEBB, MIFAZ }

final sourceValues = EnumValues({
  "flixbus": Source.FLIXBUS,
  "deutschebahn": Source.DEUTSCHEBAHN,
  "rmv": Source.RMV,
  "bvg": Source.BVG,
  "oebb": Source.OEBB,
  "mifaz": Source.MIFAZ
});
