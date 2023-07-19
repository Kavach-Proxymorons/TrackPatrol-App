import 'dart:async';
import 'package:Trackpatrol/screens/dutiesPage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/widgets/mapBottomContainer.dart';
import '../dutyServices/getDutyDetails.dart';
import '../models/dutyDetailmodel.dart';
import '../screens/loginScreen.dart';

import 'package:geocoding/geocoding.dart';

String? loc;
Completer<GoogleMapController> controllerg = Completer();
bool isLoadingDate = false;
bool isLoadingLocation = false;
bool isLoadingTimePeriod = false;
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
  late Future<DutyDetailsForDutyID?> fetchDetailDuty;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDetailDuty = getDutiesDetail(token!, shiftID!);
  }

  List<Placemark>? placemarks;
  Future<void> geocode(double lat, double long) async {
    placemarks = await placemarkFromCoordinates(lat, long);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: FutureBuilder(
        future: fetchDetailDuty,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            isLoadingDate = true;
            isLoadingLocation = true;
            isLoadingTimePeriod = true;
            return Container();
          } else if (snapshot.connectionState == ConnectionState.done) {
            isLoadingDate = false;
            isLoadingLocation = false;
            isLoadingTimePeriod = false;
          } else {
            return Text("error Finding data");
          }
          DateTime date =
              DateTime.parse(snapshot.data!.data!.startTime.toString());
          List<String> latLng = snapshot.data!.data!.duty!.location!.split(",");
          double latitude = double.parse(latLng[0]);
          double longitude = double.parse(latLng[1]);
          geocode(latitude, longitude).then((value) {
            setState(() {
              loc = placemarks![0].name.toString();
            });
          });
          return MapBottomContainer(
            date: isLoadingDate
                ? CircularProgressIndicator()
                : Text(date.day.toString() +
                    "/" +
                    date.month.toString() +
                    '/' +
                    date.year.toString()),
            timePeriod: Text("00"),
            location: isLoadingLocation
                ? CircularProgressIndicator.adaptive()
                : Text(loc == null ? "Null" : loc!),
          );
        },
      ),
      body: SingleChildScrollView(),
      // body: GoogleMap(
      //     // markers: Set<Marker>.of(markers),
      //     onMapCreated: (GoogleMapController controller) {
      //       controllerg.complete(controller);
      //     },
      //     initialCameraPosition: _kGoogle),
    );
  }
}
