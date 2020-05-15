import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:tog3ther/model/config/config.dart';

class ConfigService {
  static String CONFIG_URL = "https://api.thepublictransport.de";
  static Future<Config> get() async {
    BaseOptions options = new BaseOptions(
        baseUrl: CONFIG_URL,
        responseType: ResponseType.json
    );
    Dio httpClient = new Dio(options);

    httpClient.transformer = FlutterTransformer();

    httpClient.interceptors.add(
        DioCacheManager(
            CacheConfig(
                baseUrl: CONFIG_URL
            )
        ).interceptor
    );

    var response = await httpClient.get(
        '/assets/config.pretty.json',
        options: buildCacheOptions(
            Duration(minutes: 10),
            maxStale: Duration(hours: 3),
        )
    );

    return Config.fromJson(jsonDecode(response.data));
  }
}
