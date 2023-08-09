import 'dart:developer';
import 'package:Trackpatrol/constants/widgets/confirmDialog.dart';
import 'package:Trackpatrol/dutyServices/startDutyService.dart';
import 'package:Trackpatrol/dutyServices/stopDutyService.dart';
import 'package:Trackpatrol/maps/maps.dart';
import 'package:Trackpatrol/models/dutyStartedModel.dart';
import 'package:Trackpatrol/models/dutyStoppedModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../background-svc/background-handler.dart';
import '../../location_services/getCurrentLocation.dart';
import '../../providers/authProvider.dart';
import '../../providers/dutyTimerProvider.dart';
import '../../services/issue-services.dart';
import 'buttonForMapBottomSheetWidget.dart';
import 'failedDialog.dart';
import 'flagWidget.dart';

double? getLat;
double? getLong;
bool isSuccess = true;

class MapBottomContainer extends StatefulWidget {
  const MapBottomContainer(
      {super.key, required this.date, required this.location});
  final Widget date;

  final Widget location;

  @override
  State<MapBottomContainer> createState() => _MapBottomContainerState();
}

class _MapBottomContainerState extends State<MapBottomContainer> {
  showLoaderDialog(BuildContext ctx, String msg) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            width: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: Text(msg),
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

  DutyStartedModel? dutyStartedModel;
  late TextEditingController _descController;
  String dropdownValue = 'Select Category';
  bool _isloading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _descController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final providerTimer = Provider.of<DutyTimerProvider>(context, listen: true);
    final providerauth = Provider.of<AuthProvider>(context, listen: true);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                height: 276,
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Bandobast Details',
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Color(0xffa9a9a9)),
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
                    // SizedBox(
                    //   height: 15,
                    // ),
                    // Row(
                    //   children: <Widget>[
                    //     Image.asset(
                    //       'images/timePeriod.png',
                    //       height: 20,
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     widget.timePeriod
                    //   ],
                    // ),
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
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ButtonForBottomSheet(
                          fun: () async {
                            showLoaderDialog(
                                context, "Getting your location...");
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
                              CameraPosition cameraPosition =
                                  new CameraPosition(
                                target: LatLng(
                                    position.latitude, position.longitude),
                                zoom: 14,
                              );
                              final GoogleMapController controller =
                                  await controllerg.future;
                              controller.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                      cameraPosition));
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
                            fun: providerTimer.dutyStarted == "false"
                                ? () async {
                                    DateTime currentDateTime =
                                        DateTime.now().toUtc();
                                    showLoaderDialog(
                                        context, "Starting your duty...");
                                    SharedPreferences _prefs =
                                        await SharedPreferences.getInstance();
                                    _prefs.setString('shiftID',
                                        providerauth.shiftID.toString());
                                    dutyStartedModel = await startDuty(
                                        providerauth.token!,
                                        providerauth.shiftID!,
                                        currentDateTime.toUtc().toString());
                                    if (dutyStartedModel != null) {
                                      initializeService(context);
                                      // ignore: use_build_context_synchronously
                                      FlutterBackgroundService().invoke(
                                        'setAsForeground',
                                      );
                                      FlutterBackgroundService()
                                          .invoke('setAsBackground');
                                      providerTimer
                                          .startRepeatedFunctionCall(context);
                                      // ignore: use_build_context_synchronously

                                      Navigator.pop(context);
                                      showConfirmDialog(context);
                                      setState(() {
                                        providerTimer
                                            .updateDutyStartFlag("true");
                                        _prefs.setString(
                                            'dutyStarted',
                                            providerTimer.dutyStarted
                                                .toString());
                                      });
                                    } else {
                                      Navigator.pop(context);
                                      showFailedDialog(context);
                                    }
                                  }
                                : () async {
                                    DateTime currentDateTime =
                                        DateTime.now().toUtc();
                                    showLoaderDialog(
                                        context, "Stopping your duty...");
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    DutyStoppedModel? dutyStoppedModel =
                                        await stopDuty(
                                            providerauth.token!,
                                            providerauth.shiftID!,
                                            currentDateTime.toUtc().toString());

                                    if (dutyStoppedModel != null) {
                                      FlutterBackgroundService()
                                          .invoke('stopService');
                                      providerTimer.stopPushingGPS();
                                      Navigator.pop(context);
                                      setState(() {
                                        providerTimer
                                            .updateDutyStartFlag("false");
                                        prefs.setString(
                                            'dutyStarted',
                                            providerTimer.dutyStarted
                                                .toString());
                                      });
                                      Navigator.pop(context);
                                    } else {
                                      Navigator.pop(context);
                                      showFailedDialog(context);
                                    }
                                  },
                            title: providerTimer.dutyStarted == "false"
                                ? 'Start'
                                : 'Stop',
                            color: Color(0xff0d76d3),
                            textColor: Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
              const Positioned(
                  top: 80,
                  left: 250,
                  child: FlagContainer(flag: 'High', flagColor: Colors.red))
            ],
          ),
          Divider(
            color: Colors.grey,
            height: 4,
            endIndent: 20,
            indent: 20,
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "Report Issue",
              style: GoogleFonts.poppins(color: Colors.blue, fontSize: 20),
            ),
          ),
          Text("Issue", style: GoogleFonts.poppins(color: Colors.black)),
          DropdownButton<String>(
            // Step 3.
            value: dropdownValue,
            // Step 4.
            items: <String>[
              'Select Category',
              'Internet Issue',
              'Network Issue',
              'Battery Issue',
              'Crowd Issue',
              'Others',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: GoogleFonts.poppins(fontSize: 15, color: Colors.grey),
                ),
              );
            }).toList(),
            // Step 5.
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
          ),
          SizedBox(height: 20),
          Text("Description", style: GoogleFonts.poppins(color: Colors.black)),
          TextFormField(
            controller: _descController,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                hintText: "I have a problem regarding...",
                hintStyle: GoogleFonts.poppins(),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black))),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Visibility(
              visible: providerTimer.dutyStarted == "false" ? false : true,
              child: InkWell(
                onTap: () async {
                  setState(() {
                    _isloading = true;
                  });
                  var fetch = issuePost(
                          providerauth.token.toString(),
                          dropdownValue,
                          _descController.text,
                          providerauth.shiftID.toString())
                      .whenComplete(() => showSimpleNotification(
                          Text("Issue Status"),
                          trailing: Text("Issue successfully reported"),
                          background: Colors.green));
                  setState(() {
                    _isloading = false;
                  });
                },
                child: Container(
                  height: 40,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: _isloading
                        ? const CircularProgressIndicator.adaptive()
                        : Text(
                            "Submit",
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
