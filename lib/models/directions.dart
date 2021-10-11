import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:native_features/utils/constants.dart';

class Directions {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;

  Directions({
    @required this.bounds,
    @required this.polylinePoints,
    @required this.totalDistance,
    @required this.totalDuration,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    // Check if route is not available
    if ((map[apiRoutes] as List).isEmpty) return null;

    // Get route information
    final data = Map<String, dynamic>.from(map[apiRoutes][0]);

    // Bounds
    final northeast = data[apiBounds][apiNortheast];
    final southwest = data[apiBounds][apiSouthwest];
    final bounds = LatLngBounds(
      southwest: LatLng(southwest[apiLatitude], southwest[apiLongitude]),
      northeast: LatLng(northeast[apiLatitude], northeast[apiLongitude]),
    );

    // Distance & Duration
    String distance = '';
    String duration = '';
    if ((data[apiLegs] as List).isNotEmpty) {
      final leg = data[apiLegs][0];
      distance = leg[apiDistance][apiText];
      duration = leg[apiDuration][apiText];
    }

    return Directions(
      bounds: bounds,
      polylinePoints:
          PolylinePoints().decodePolyline(data[apiOverviewPolyline][apiPoints]),
      totalDistance: distance,
      totalDuration: duration,
    );
  }
}
