import 'package:flutter/material.dart';
import 'package:native_features/providers/user_places.dart';
import 'package:native_features/screens/map_screen.dart';
import 'package:native_features/utils/constants.dart';
import 'package:provider/provider.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routeName = 'place-details';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<UserPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: marginHorizontal, vertical: marginVertical),
        child: Column(
          children: [
            Container(
              height: 250.0,
              width: double.infinity,
              child: Image.file(
                selectedPlace.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              selectedPlace.location.address,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MapScreen(initialLocation: selectedPlace.location);
                    },
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Text('View on Map'),
            ),
          ],
        ),
      ),
    );
  }
}
