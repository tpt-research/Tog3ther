import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:tog3ther/model/geojson/geojson.dart';
import 'package:tog3ther/model/hafas/hafas_location.dart';

class HafasService {

  static String HAFAS_URL = 'https://api.thepublictransport.de';

  static Future<HafasLocation> query(String query) async {
    BaseOptions options = new BaseOptions(
        baseUrl: HAFAS_URL,
        responseType: ResponseType.json
    );
    Dio httpClient = new Dio(options);

    httpClient.transformer = FlutterTransformer();

    if (!kIsWeb) {
      httpClient.interceptors.add(
          DioCacheManager(
              CacheConfig(
                  baseUrl: HAFAS_URL
              )
          ).interceptor
      );
    }

    var response = await httpClient.get(
        '/location/suggest',
        queryParameters: {
          'q': query,
          'maxLocations': 5,
          'maxDistance': 5000,
          'source': 'DB'
        },
        options: buildCacheOptions(
            Duration(minutes: 10),
            maxStale: Duration(microseconds: 30),
            subKey: "q=" + query
        )
    );

    return HafasLocation.fromJson(response.data);
  }

  static Future<HafasLocation> reverse(double lat, double lon) async {
    BaseOptions options = new BaseOptions(
        baseUrl: HAFAS_URL,
        responseType: ResponseType.json
    );
    Dio httpClient = new Dio(options);

    httpClient.transformer = FlutterTransformer();

    var response = await httpClient.get(
        '/location/nearby',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'types': 'STATION,ADDRESS,POI',
          'maxDistance': 10000,
          'maxLocations': 1,
          'source': 'DB'
        },
    );

    return HafasLocation.fromJson(response.data);
  }

  static hafasToGeojson(HafasLocation location) {
    GeoJSON geojson = GeoJSON(
      features: [],
      type: 'HafasFeatureCollection'
    );

    if (location.suggestedLocations == null) {
      for (var suggested in location.locations) {
        Geometry geometry = Geometry(
            coordinates: [
              suggested.lonAsDouble,
              suggested.latAsDouble
            ],
            type: 'Geometry'
        );

        Properties properties = Properties(
            name: suggested.name + (suggested.place != null ? ", " + suggested.place : "")
        );

        Feature feature = Feature(
            geometry: geometry,
            properties: properties,
            type: 'Feature'
        );

        geojson.features.add(feature);
      }
    } else {
      for (var suggested in location.suggestedLocations) {
        Geometry geometry = Geometry(
            coordinates: [
              suggested.location.lonAsDouble,
              suggested.location.latAsDouble
            ],
            type: 'Geometry'
        );

        Properties properties = Properties(
            name: suggested.location.name + (suggested.location.place != null ? ", " + suggested.location.place : "")
        );

        Feature feature = Feature(
            geometry: geometry,
            properties: properties,
            type: 'Feature'
        );

        geojson.features.add(feature);
      }
    }



    return geojson;
  }
}
