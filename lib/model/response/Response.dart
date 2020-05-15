import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tog3ther/model/shuvi/Shuvi.dart';

class ServiceResponse {
  bool success;
  String status;
  Shuvi data;

  ServiceResponse({
    @required this.success,
    @required this.status,
    this.data,
  });

  factory ServiceResponse.fromRawJson(String str) => ServiceResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceResponse.fromJson(Map<String, dynamic> json) => ServiceResponse(
    success: json["success"] == null ? null : json["from"],
    status: json["status"] == null ? null : json["result"],
    data: json["data"] == null ? null : Shuvi.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "status": status == null ? null : status,
    "data": data == null ? null : data.toJson(),
  };
}
