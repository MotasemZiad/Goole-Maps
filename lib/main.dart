import 'package:flutter/material.dart';
import 'package:native_features/providers/user_places.dart';
import 'package:native_features/screens/add_place_screen.dart';
import 'package:native_features/screens/main_screen.dart';
import 'package:native_features/screens/place_details_screen.dart';
import 'package:native_features/screens/places_list_screen.dart';
import 'package:native_features/utils/constants.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserPlaces>.value(
      value: UserPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Great Places',
        themeMode: ThemeMode.system,
        theme: ThemeData(
          primarySwatch: primaryColor,
          accentColor: accentColor,
          primaryColorBrightness: Brightness.dark,
        ),
        home: MainScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
          PlaceDetailsScreen.routeName: (context) => PlaceDetailsScreen(),
        },
      ),
    );
  }
}
