import 'package:latlong/latlong.dart';

calculateDistance(LatLng from, LatLng to) {
  final Distance distance = new Distance();

  return round(distance.as(LengthUnit.Meter, from, to) / 1000, decimals: 2);
}
