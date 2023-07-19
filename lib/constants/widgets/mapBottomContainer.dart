import 'dart:developer';
import 'package:Trackpatrol/maps/maps.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../location_services/getCurrentLocation.dart';
import 'buttonForMapBottomSheetWidget.dart';
import 'failedDialog.dart';
import 'flagWidget.dart';

double? getLat;
double? getLong;
bool isSuccess = true;

class MapBottomContainer extends StatefulWidget {
  const MapBottomContainer(
      {super.key,
      required this.date,
      required this.timePeriod,
      required this.location});
  final Widget date;
  final Widget timePeriod;
  final Widget location;

  @override
  State<MapBottomContainer> createState() => _MapBottomContainerState();
}

class _MapBottomContainerState extends State<MapBottomContainer> {
  showLoaderDialog(BuildContext ctx) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            width: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Getting your location..."),
          ),
        ],
      ),
    );
    showDialog(
      useRootNavigator: false,
      barrierDismissible: false,
      context: context,
      builder: (BuildContext ctx) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          height: 276,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Text(
                'Bandobast Details',
                style:
                    GoogleFonts.poppins(fontSize: 16, color: Color(0xffa9a9a9)),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Image.asset(
                    'images/date.png',
                    height: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  widget.date
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Image.asset(
                    'images/timePeriod.png',
                    height: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  widget.timePeriod
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Image.asset(
                    'images/loc.png',
                    height: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  widget.location
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ButtonForBottomSheet(
                    fun: () async {
                      showLoaderDialog(context);
                      Position position = await getUserCurrentLocation();
                      if (position.latitude != 000000000) {
                        // Navigator.pop(context);
                        setState(() {
                          getLat = position.latitude;
                          getLong = position.longitude;
                        });
                        log(position.latitude.toString() +
                            " " +
                            position.longitude.toString());
                        Navigator.pop(context);
                        CameraPosition cameraPosition = new CameraPosition(
                          target: LatLng(position.latitude, position.longitude),
                          zoom: 14,
                        );
                        final GoogleMapController controller =
                            await controllerg.future;
                        controller.animateCamera(
                            CameraUpdate.newCameraPosition(cameraPosition));
                        setState(() {});
                      } else {
                        ScaffoldMessenger(
                            child: Text("Error getting location"));
                      }
                    },
                    title: 'Check location',
                    color: Colors.white,
                    textColor: Color(0xff0d76d3),
                  ),
                  ButtonForBottomSheet(
                      fun: () {
                        showFailedDialog(context);
                      },
                      title: 'Start',
                      color: Color(0xff0d76d3),
                      textColor: Colors.white)
                ],
              ),
            ],
          ),
        ),
        const Positioned(
            top: 80,
            left: 300,
            child: FlagContainer(flag: 'High', flagColor: Colors.red))
      ],
    );
  }
}
