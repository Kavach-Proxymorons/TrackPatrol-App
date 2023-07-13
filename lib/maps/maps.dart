import 'dart:async';

import 'package:Trackpatrol/constants/widgets/flagWidget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../constants/widgets/mapBottomContainer.dart';

Completer<GoogleMapController> controllerg = Completer();
final List<Marker> markers = <Marker>[
  Marker(
      markerId: MarkerId('1'),
      position: LatLng(20.42796133580664, 75.885749655962),
      infoWindow: InfoWindow(
        title: 'My Position',
      )),
];

class MapRender extends StatefulWidget {
  const MapRender({super.key});

  @override
  State<MapRender> createState() => _MapRenderState();
}

class _MapRenderState extends State<MapRender> {
  late GoogleMapController mapController;

  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        bottomSheet: MapBottomContainer(
            date: '07/07/2023',
            timePeriod: '00:00 am - 09:00 am',
            location: 'Location'),
        body: GoogleMap(
            // markers: Set<Marker>.of(markers),
            onMapCreated: (GoogleMapController controller) {
              controllerg.complete(controller);
            },
            initialCameraPosition: _kGoogle),
      ),
    );
  }
}
