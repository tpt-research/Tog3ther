import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tog3ther/model/shibi/Shibi.dart';

import 'SearchObject.dart';

class Shuvi {
  SearchObject from;
  Shibi result;
  SearchObject to;

  Shuvi({
    @required this.from,
    this.result,
    @required this.to,
  });

  factory Shuvi.fromRawJson(String str) => Shuvi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Shuvi.fromJson(Map<String, dynamic> json) => Shuvi(
    from: json["from"] == null ? null : SearchObject.fromJson(json["from"]),
    result: json["result"] == null ? null : Shibi.fromJson(json["result"]),
    to: json["to"] == null ? null : SearchObject.fromJson(json["to"]),
  );

  Map<String, dynamic> toJson() => {
    "from": from == null ? null : from.toJson(),
    "result": result == null ? null : result.toJson(),
    "to": to == null ? null : to.toJson(),
  };
}
