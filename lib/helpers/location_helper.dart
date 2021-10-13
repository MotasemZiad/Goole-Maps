import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/.env.dart';

class LocationHelper {
  LocationHelper._();
  static final locationHelper = LocationHelper._();

  String generateLocationPreviewImage({double latitude, double longitude}) {
    return '''https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey''';
  }

  Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleApiKey';
    final response = await Dio().get(url);
    return json.decode(response.data)['results'][0]['formatted_address'];
  }
}
