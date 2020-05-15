import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:tog3ther/model/geojson/geojson.dart';
import 'package:tog3ther/util/photon_util.dart';

class PhotonService {

  static String PHOTON_URL = 'https://photon.komoot.de';

  static Future<GeoJSON> query(String query) async {
    BaseOptions options = new BaseOptions(
      baseUrl: PHOTON_URL,
      responseType: ResponseType.json
    );
    Dio httpClient = new Dio(options);

    httpClient.transformer = FlutterTransformer();

    httpClient.interceptors.add(
        DioCacheManager(
            CacheConfig(
                baseUrl: PHOTON_URL
            )
        ).interceptor
    );

    var response = await httpClient.get(
        '/api',
        queryParameters: genHeader(query),
        options: buildCacheOptions(
            Duration(minutes: 10),
            maxStale: Duration(microseconds: 30),
            subKey: "q=" + query
        )
    );

    print(response.request.uri.toString());

    return GeoJSON.fromJson(response.data);
  }

  static Future<GeoJSON> reverse(double lat, double lon) async {
    BaseOptions options = new BaseOptions(
        baseUrl: PHOTON_URL,
        responseType: ResponseType.json
    );
    Dio httpClient = new Dio(options);

    httpClient.transformer = FlutterTransformer();

    httpClient.interceptors.add(
        DioCacheManager(
            CacheConfig(
                baseUrl: PHOTON_URL
            )
        ).interceptor
    );

    var response = await httpClient.get(
        '/reverse',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'limit': 1,
          'lang': 'de'
        },
        options: buildCacheOptions(
            Duration(minutes: 10),
            maxStale: Duration(microseconds: 30),
            subKey: "q=" + lat.toString() + "_" + lon.toString()
        )
    );

    print(response.request.uri.toString());

    return GeoJSON.fromJson(response.data);
  }
}
