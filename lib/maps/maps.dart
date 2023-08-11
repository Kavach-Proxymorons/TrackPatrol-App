import 'dart:async';
import 'dart:developer';
import 'package:Trackpatrol/location_services/getCurrentLocation.dart';
import 'package:Trackpatrol/providers/authProvider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../constants/widgets/connectivityStatus.dart';
import '../constants/widgets/mapBottomContainer.dart';
import '../dutyServices/getDutyDetails.dart';
import '../models/dutyDetailmodel.dart';
import '../providers/dutyTimerProvider.dart';
import '../providers/locationProvider.dart';

import 'package:geocoding/geocoding.dart';

import '../providers/offline-provider.dart';

String? loc;
List<String>? latLng;
double? dutylatitude;
double? dutylongitude;
Completer<GoogleMapController> controllerg = Completer();
bool isLoadingDate = false;
bool isLoadingLocation = false;
bool isLoadingTimePeriod = false;
late StreamSubscription connectionSubscription;

class MapRender extends StatefulWidget {
  const MapRender({super.key});

  @override
  State<MapRender> createState() => _MapRenderState();
}

class _MapRenderState extends State<MapRender> {
  late GoogleMapController mapController;

  late Future<DutyDetailsForDutyID?> fetchDetailDuty;
  Position? position;
  void _getMyLoc() async {
    position = await getUserCurrentLocation();
  }

  static double? latitude = 1;
  static double? longitude = 1;

  // void _getStatus() async {
  //   log("ram");
  //   var _connect = await Provider.of<OfflineProvider>(context, listen: true)
  //       .checkConnection();
  //   print(_connect);

  //   if (_connect == ConnectivityResult.mobile) {
  //     log("network");
  //   }
  //   if (_connect == null) {
  //     log("network1");
  //   }
  //   StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
  //           locationSettings:
  //               LocationSettings(accuracy: LocationAccuracy.bestForNavigation))
  //       .listen((Position? position) {
  //     log(position == null
  //         ? 'Unknown'
  //         : '${position.latitude.toString()}, ${position.longitude.toString() + "from duties"}');
  //     if (_connect == null) {
  //       Provider.of<LocationProvider>(context, listen: false)
  //           .updateArray(position!);
  //     }
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    final offlineProvider =
        Provider.of<OfflineProvider>(context, listen: false);
    super.initState();
    connectionSubscription =
        Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);

    fetchDetailDuty = getDutiesDetail(
        Provider.of<AuthProvider>(context, listen: false).token.toString(),
        Provider.of<AuthProvider>(context, listen: false).shiftID.toString());
    latitude = Provider.of<LocationProvider>(context, listen: false).latitude;
    longitude = Provider.of<LocationProvider>(context, listen: false).longitude;

    Connectivity().onConnectivityChanged.listen(
      (event) {
        StreamSubscription<Position> positionStream =
            Geolocator.getPositionStream(
                    locationSettings: LocationSettings(
                        accuracy: LocationAccuracy.bestForNavigation))
                .listen((Position? position) {
          if (event == ConnectivityResult.none ||
              offlineProvider.previousConnectivity == ConnectivityResult.none) {
            log("network changed from online to offline");
            offlineProvider.updatePreviousConnectivity(event);
            // Provider.of<LocationProvider>(context, listen: false)
            //     .updateArray(position!);
          } else {
            log("network changed from offline to online");
            // Provider.of<LocationProvider>(context, listen: false)
            //     .emptyOfflineData();
            log("offline array flushed");
            offlineProvider.updatePreviousConnectivity(event);
          }
        });
      },
    );

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _getMyLoc();
    //   log(getLat.toString());
    //   log(getLong.toString());
    // });
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   if (Provider.of<OfflineProvider>(context, listen: true)
  //               .connectivityResult ==
  //           ConnectivityResult.none &&
  //       Provider.of<DutyTimerProvider>(context, listen: true).dutyStarted ==
  //           "true") {
  //     Provider.of<LocationProvider>(context, listen: true)
  //         .updateArray(position!);
  //   }
  // }
  // @override
  // void didUpdateWidget(covariant MapRender oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);

  //   StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
  //           locationSettings:
  //               LocationSettings(accuracy: LocationAccuracy.bestForNavigation))
  //       .listen((Position? position) {
  //     log(position == null
  //         ? 'Unknown'
  //         : '${position.latitude.toString()}, ${position.longitude.toString() + "from maps"}');
  //     if (Provider.of<OfflineProvider>(context, listen: false)
  //             .checkConnection() ==
  //         ConnectivityResult.none) {
  //       log("network changed");
  //       Provider.of<LocationProvider>(context, listen: false)
  //           .updateArray(position!);
  //     }
  //   });
  // }

  static final CameraPosition _kGoogle = CameraPosition(
    target: LatLng(latitude!, longitude!),
    zoom: 4,
  );

  List<Placemark>? placemarks;
  Future<void> geocode(double lat, double long) async {
    placemarks = await placemarkFromCoordinates(lat, long);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context, listen: false);

    return Scaffold(
      bottomSheet: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        height: 320,
        child: FutureBuilder(
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
              // timePeriod: Text("00"),
              location: isLoadingLocation
                  ? const CircularProgressIndicator.adaptive()
                  : Text(loc == null ? "Null" : loc!),
            );
          },
        ),
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
                position: LatLng(provider.latitude!, provider.longitude!),
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
