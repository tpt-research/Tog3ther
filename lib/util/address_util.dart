import 'package:tog3ther/model/geojson/geojson.dart';

String generateAddress(Feature place) {
  var name = place.properties.name;

  if (place.properties.street != null) {
    if (name != place.properties.street) {
      name += ", " + place.properties.street;
    }
  }

  if (place.properties.housenumber != null) {
    if (name != place.properties.housenumber) {
      name += " " + place.properties.housenumber;
    }
  }

  if (place.properties.city != null) {
    if (name != place.properties.city) {
      name += ", " + place.properties.city;
    }
  }

  return name;
}
