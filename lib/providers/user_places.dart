import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:native_features/helpers/db_helper.dart';
import 'package:native_features/models/place.dart';
import 'package:native_features/utils/constants.dart';

class UserPlaces extends ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items => [..._items];

  void addPlace(String title, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: null,
      image: pickedImage,
    );
    _items.add(newPlace);
    notifyListeners();
    DbHelper.dbHelper.insert(tableName, {
      tableColumnId: newPlace.id,
      tableColumnTitle: newPlace.title,
      tableColumnImage: newPlace.image.path,
    });
  }

  Future<void> fetchPlaces() async {
    final dataList = await DbHelper.dbHelper.getData(tableName);
    _items = dataList
        .map(
          (e) => Place(
            id: e[tableColumnId],
            title: e[tableColumnTitle],
            location: null,
            image: File(e[tableColumnImage]),
          ),
        )
        .toList();
    notifyListeners();
  }
}
