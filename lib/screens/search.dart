import 'package:flutter/material.dart';
import 'package:flutter_parking_locator_with_google_maps/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Place>>>(context);

    return FutureProvider(
      create: (context) => placesProvider,
      child: Scaffold(
          body: (currentPosition != null)
              ? Consumer<List<Place>>(
                  builder: (_, places, __) {
                    return Column(
                      children: <Widget>[
                        Container(
                          height: size.height / 3,
                          width: size.width,
                          child: GoogleMap(
                            zoomGesturesEnabled: true,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(currentPosition.latitude,
                                    currentPosition.longitude),
                                zoom: 16.0),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: places.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(places[index].name),
                                  ),
                                );
                              }),
                        )
                      ],
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
