import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:native_features/helpers/db_helper.dart';
import 'package:native_features/helpers/location_helper.dart';
import 'package:native_features/models/place.dart';
import 'package:native_features/utils/constants.dart';

class UserPlaces extends ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items => [..._items];

  Place findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addPlace(
    String title,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.locationHelper
        .getPlaceAddress(pickedLocation.latitude, pickedLocation.longitude);
    final updateLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: updateLocation,
      image: pickedImage,
    );
    _items.add(newPlace);
    notifyListeners();
    DbHelper.dbHelper.insert(tableName, {
      tableColumnId: newPlace.id,
      tableColumnTitle: newPlace.title,
      tableColumnImage: newPlace.image.path,
      tableColumnLocationLatitude: newPlace.location.latitude,
      tableColumnLocationLongitude: newPlace.location.longitude,
      tableColumnAddress: newPlace.location.address,
    });
  }

  Future<void> fetchPlaces() async {
    final dataList = await DbHelper.dbHelper.getData(tableName);
    _items = dataList
        .map(
          (e) => Place(
            id: e[tableColumnId],
            title: e[tableColumnTitle],
            location: PlaceLocation(
              latitude: e[tableColumnLocationLatitude],
              longitude: e[tableColumnLocationLongitude],
              address: e[tableColumnAddress],
            ),
            image: File(e[tableColumnImage]),
          ),
        )
        .toList();
    notifyListeners();
  }
}
