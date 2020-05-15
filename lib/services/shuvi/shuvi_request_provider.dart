import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tog3ther/model/response/Response.dart';
import 'package:tog3ther/model/searchcluster/SearchCluster.dart';
import 'package:tog3ther/model/shuvi/Shuvi.dart';

class ShuviRequestProvider {

  static SearchCluster createCluster({
    double fromLatitude,
    double fromLongitude,
    double toLatitude,
    double toLongitude,
    String fromName,
    String toName,
    List<String> sources,
    DateTime date
  }) {
    Map<String, dynamic> from = {
      "latitude": fromLatitude,
      "longitude": fromLongitude,
      "name": fromName
    };

    Map<String, dynamic> to = {
      "latitude": toLatitude,
      "longitude": toLongitude,
      "name": toName
    };

    Map<String, dynamic> mapped = {
      "from": from,
      "to": to,
      "date": date.toIso8601String(),
      "sources": sources
    };

    return SearchCluster.fromJson(mapped);
  }

  static Future<Shuvi> handshake(SearchCluster search) async {
    Dio httpManager = Dio();

    httpManager.transformer = FlutterTransformer();

    httpManager.interceptors.add(
        DioCacheManager(
            CacheConfig(
              baseUrl: "https://api.thepublictransport.de",
            )
        ).interceptor
    );
    var rawResponse;

    try {
      rawResponse = await httpManager.post(
        "https://api.thepublictransport.de/shuvi/handshake",
        data: search.toJson(),
        options: buildCacheOptions(
            Duration(seconds: 3),
            maxStale: Duration(days: 1),
            options: Options(
                contentType: ContentType.json.toString(),
                responseType: ResponseType.json,
                followRedirects: false,
                receiveDataWhenStatusError: false,
                validateStatus: (status) { return status < 500; }
            )
        ),
      );
    } on DioError catch(e) {
      return Shuvi(
        result: null, from: null, to: null
      );
    }

    if (rawResponse == null) {
      return Shuvi(
          result: null, from: null, to: null
      );
    }

    return ServiceResponse.fromJson(rawResponse.data).data;
  }

  static Future<Shuvi> get(SearchCluster search) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool("detailed_search") == true) {
      return detailed(search);
    } else {
      return handshake(search);
    }
  }

  static Future<Shuvi> detailed(SearchCluster search) async {
    Dio httpManager = Dio();

    httpManager.transformer = FlutterTransformer();

    httpManager.interceptors.add(
        DioCacheManager(
            CacheConfig(
                baseUrl: "https://api.thepublictransport.de",
            )
        ).interceptor
    );

    var rawResponse;

    try {
      rawResponse = await httpManager.post(
        "https://api.thepublictransport.de/shuvi/search",
        data: search.toJson(),
        options: buildCacheOptions(
            Duration(seconds: 3),
            maxStale: Duration(days: 1),
            options: Options(
              contentType: ContentType.json.toString(),
              responseType: ResponseType.json,
              followRedirects: false,
              receiveDataWhenStatusError: true,
              sendTimeout: 7000
            )
        ),
      );
    } on DioError catch(e) {
      return Shuvi(
          result: null, from: null, to: null
      );
    }

    if (rawResponse == null) {
      return Shuvi(
          result: null, from: null, to: null
      );
    }

    return ServiceResponse.fromJson(rawResponse.data).data;
  }
}
