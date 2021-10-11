import 'package:flutter/material.dart';
import 'package:native_features/providers/user_places.dart';
import 'package:native_features/screens/add_place_screen.dart';
import 'package:native_features/utils/constants.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<UserPlaces>(context, listen: false).fetchPlaces(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: LinearProgressIndicator(),
                  )
                : Consumer<UserPlaces>(
                    builder: (context, userPlacesProvider, child) =>
                        userPlacesProvider.items.length < 1
                            ? child
                            : ListView.builder(
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: marginVertical,
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: FileImage(
                                        userPlacesProvider.items[index].image,
                                      ),
                                      radius: 36.0,
                                    ),
                                    title: Text(
                                      userPlacesProvider.items[index].title[0]
                                              .toUpperCase() +
                                          userPlacesProvider.items[index].title
                                              .substring(1),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onTap: () {
                                      // Go to Details Screen
                                    },
                                  ),
                                ),
                                itemCount: userPlacesProvider.items.length,
                                physics: BouncingScrollPhysics(),
                              ),
                    child: Center(
                      child: Text(
                        'Got no places yet, try adding some!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddPlaceScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
