import 'dart:async';
import 'dart:developer';
import 'package:Trackpatrol/location_services/getCurrentLocation.dart';
import 'package:Trackpatrol/screens/dutiesPage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/widgets/mapBottomContainer.dart';
import '../dutyServices/getDutyDetails.dart';
import '../models/dutyDetailmodel.dart';
import '../screens/loginScreen.dart';

import 'package:geocoding/geocoding.dart';

String? loc;
List<String>? latLng;
double? dutylatitude;
double? dutylongitude;
Completer<GoogleMapController> controllerg = Completer();
bool isLoadingDate = false;
bool isLoadingLocation = false;
bool isLoadingTimePeriod = false;

class MapRender extends StatefulWidget {
  const MapRender({super.key});

  @override
  State<MapRender> createState() => _MapRenderState();
}

class _MapRenderState extends State<MapRender> {
  late GoogleMapController mapController;

  static final CameraPosition _kGoogle = CameraPosition(
    target: LatLng(getLat!, getLong!),
    zoom: 4,
  );
  late Future<DutyDetailsForDutyID?> fetchDetailDuty;
  Position? position;
  void _getMyLoc() async {
    position = await getUserCurrentLocation();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDetailDuty = getDutiesDetail(token!, shiftID!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getMyLoc();
      log(getLat.toString());
      log(getLong.toString());
    });
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
            return const Text("error Finding data");
          }
          DateTime date =
              DateTime.parse(snapshot.data!.data!.startTime.toString());
          WidgetsBinding.instance.addPostFrameCallback((_) {
            latLng = snapshot.data!.data!.duty!.location!.split(",");
            dutylatitude = double.parse(latLng![0]);
            dutylongitude = double.parse(latLng![1]);
            geocode(dutylatitude!, dutylongitude!).then((value) {
              setState(() {
                loc = placemarks![0].locality.toString();
              });
            });
          });
          return MapBottomContainer(
            date: isLoadingDate
                ? const CircularProgressIndicator()
                // ignore: prefer_interpolation_to_compose_strings
                : Text(date.day.toString() +
                    "/" +
                    date.month.toString() +
                    '/' +
                    date.year.toString()),
            timePeriod: Text("00"),
            location: isLoadingLocation
                ? const CircularProgressIndicator.adaptive()
                : Text(loc == null ? "Null" : loc!),
          );
        },
      ),
      // body: SingleChildScrollView(),
      body: SafeArea(
        child: GoogleMap(
            myLocationEnabled: true,
            // markers: Set<Marker>.of(markers),
            // ignore: prefer_collection_literals
            markers: Set<Marker>.of([
              Marker(
                markerId: MarkerId("Duty Location"),
                position: LatLng(
                    dutylatitude == null
                        ? 37.422346754908716
                        : dutylatitude!, // for null, location are of googleplex
                    dutylongitude == null
                        ? -122.08434719141799
                        : dutylongitude!),
              ),
              Marker(
                visible: true,
                markerId: MarkerId("My Location"),
                position: LatLng(getLat!, getLong!),
              ),
            ]),
            onMapCreated: (GoogleMapController controller) {
              controllerg.complete(controller);
            },
            initialCameraPosition: _kGoogle),
      ),
    );
  }
}
