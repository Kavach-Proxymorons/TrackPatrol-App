import 'dart:async';
import 'dart:developer';

import 'package:Trackpatrol/dutyServices/getAlldutiesService.dart';
import 'package:Trackpatrol/maps/maps.dart';
import 'package:Trackpatrol/providers/authProvider.dart';
import 'package:Trackpatrol/providers/dutyTimerProvider.dart';
import 'package:Trackpatrol/providers/offline-provider.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../providers/offline-provider.dart';
import '../constants/widgets/connectivityStatus.dart';
import '../constants/widgets/dutyWidget.dart';
import '../constants/widgets/pop-up.dart';
import '../models/allDutiesmodel.dart';
import '../providers/locationProvider.dart';

bool dutyListEmpty = false;
Duration? timePer;

class DutiesPage extends StatefulWidget {
  const DutiesPage({super.key});

  @override
  State<DutiesPage> createState() => _DutiesPageState();
}

class _DutiesPageState extends State<DutiesPage> {
  late Future<AllDuties?> fetch;
  GetDutyclass getDutyclass = GetDutyclass();
  late StreamSubscription subscription;
  late StreamSubscription statusConnect;

  // void _getStatus() async {
  //   log("ram");
  //   var _connect = await Provider.of<OfflineProvider>(context, listen: true)
  //       .checkConnection();
  //   print(_connect);

  //   if (_connect == ConnectivityResult.mobile) {
  //     log("network");
  //   }
  //   if (_connect == ConnectivityResult.none) {
  //     log("no network");
  //   }
  //   StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
  //           locationSettings:
  //               LocationSettings(accuracy: LocationAccuracy.bestForNavigation))
  //       .listen((Position? position) {
  //     log(position == null
  //         ? 'Unknown'
  //         : '${position.latitude.toString()}, ${position.longitude.toString() + "from duties"}');
  //     if (Provider.of<OfflineProvider>(context, listen: false)
  //             .checkConnection() ==
  //         ConnectivityResult.none) {
  //       Provider.of<LocationProvider>(context, listen: false)
  //           .updateArray(position!);
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // var previousConnectivity = ConnectivityResult.mobile;
    // subscription =
    //     Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);
    // Connectivity().onConnectivityChanged.listen(
    //   (event) {
    //     StreamSubscription<Position> positionStream =
    //         Geolocator.getPositionStream(
    //                 locationSettings: LocationSettings(
    //                     accuracy: LocationAccuracy.bestForNavigation))
    //             .listen((Position? position) {
    //       if (event == ConnectivityResult.none &&
    //           previousConnectivity != ConnectivityResult.none) {
    //         // Provider.of<LocationProvider>(context, listen: false)
    //         //     .updateArray(position!);
    //         log(previousConnectivity.toString() + "event change");
    //       }
    //       if (event == ConnectivityResult.mobile ||
    //           event == ConnectivityResult.wifi) {
    //         Provider.of<LocationProvider>(context, listen: false)
    //             .emptyOfflineData();
    //         log("offline array flushed");
    //         previousConnectivity = event;
    //       }
    //     });
    //   },
    // );
    // _getStatus();

    Provider.of<AuthProvider>(context, listen: false).getPrefs();
    Provider.of<LocationProvider>(context, listen: false).getposition();

    // StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
    //         locationSettings:
    //             LocationSettings(accuracy: LocationAccuracy.bestForNavigation))
    //     .listen((Position? position) {
    //   log(position == null
    //       ? 'Unknown'
    //       : '${position.latitude.toString()}, ${position.longitude.toString() + "from duties"}');
    //   if (Provider.of<OfflineProvider>(context, listen: false)
    //               .connectivityResult ==
    //           ConnectivityResult.none &&
    //       Provider.of<DutyTimerProvider>(context, listen: false).dutyStarted ==
    //           "true") {
    //     log("networks changed");
    //     Provider.of<LocationProvider>(context, listen: false)
    //         .updateArray(position!);
    //   }
    // });
    // if (Provider.of<OfflineProvider>(context, listen: false)
    //             .connectivityResult ==
    //         ConnectivityResult.mobile ||
    //     Provider.of<OfflineProvider>(context, listen: false)
    //             .connectivityResult ==
    //         ConnectivityResult.wifi) {
    //   if (Provider.of<LocationProvider>(context, listen: false)
    //           .offlineData
    //           .length >
    //       1) {
    //     Provider.of<LocationProvider>(context, listen: false)
    //         .pushOfflineLocation(context);
    //     Provider.of<LocationProvider>(context, listen: false)
    //         .emptyOfflineData();
    //   }
    // }
    // log(Provider.of<LocationProvider>(context, listen: false)
    //         .offlineData
    //         .first!
    //         .latitude
    //         .toString() +
    //     "Hii");
  }

  // @override
  // void didUpdateWidget(covariant DutiesPage oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  //   StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
  //           locationSettings:
  //               LocationSettings(accuracy: LocationAccuracy.bestForNavigation))
  //       .listen((Position? position) {
  //     log(position == null
  //         ? 'Unknown'
  //         : '${position.latitude.toString()}, ${position.longitude.toString() + "from duties"}');
  //     if (Provider.of<OfflineProvider>(context, listen: true)
  //             .checkConnection() ==
  //         ConnectivityResult.none) {
  //       Provider.of<LocationProvider>(context, listen: false)
  //           .updateArray(position!);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: true);

    fetch = getDutyclass.getDuties(provider.token.toString());
    List<Placemark>? placemarks;
    Future<void> geocode(double lat, double long) async {
      placemarks = await placemarkFromCoordinates(lat, long);
    }

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        actions: [
          Icon(Icons.account_circle_rounded),
          PopUp(),
          SizedBox(
            width: 10,
          )
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png', height: 40),
            Text('TRACKPATROL',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
      body: FutureBuilder(
          future: fetch,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.data?.data?.shifts?.isEmpty ?? true) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  dutyListEmpty = true;
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  dutyListEmpty = false;
                });
              }
            }
            return dutyListEmpty
                ? Center(
                    child: Text(
                      "No Duties for this personnal",
                      style: GoogleFonts.poppins(),
                    ),
                  )
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Text(
                          //   'Starts in 1 Hour',
                          //   style: GoogleFonts.poppins(
                          //     fontWeight: FontWeight.w600,
                          //     color: Color(0xff0D76D3),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // InkWell(
                          //   onTap: () async {
                          //     await Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => MapRender()));
                          //   },
                          //   child: Container(
                          //     height: 75,
                          //     width: double.infinity,
                          //     decoration: BoxDecoration(
                          //         border: Border.all(color: Color(0xff0D76D3)),
                          //         borderRadius: BorderRadius.circular(20)),
                          //     child: Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Container(
                          //           decoration: BoxDecoration(
                          //               color: Color(0xff0D76D3),
                          //               border: Border.all(
                          //                   color: Color(0xff0D76D3)),
                          //               borderRadius:
                          //                   BorderRadius.circular(19)),
                          //           height: 75,
                          //           width: 91,
                          //           child: Center(
                          //             child: Text(
                          //               DateTime.parse(snapshot.data!.data!
                          //                           .shifts![0].startTime
                          //                           .toString())
                          //                       .toLocal()
                          //                       .hour
                          //                       .toString() +
                          //                   "${":"}" +
                          //                   DateTime.parse(snapshot.data!.data!
                          //                           .shifts![0].startTime
                          //                           .toString())
                          //                       .toLocal()
                          //                       .minute
                          //                       .toString() +
                          //                   "am",
                          //               style: GoogleFonts.poppins(
                          //                   color: Colors.white),
                          //             ),
                          //           ),
                          //         ),
                          //         // SizedBox(
                          //         //   width: 5,
                          //         // ),
                          //         Column(
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.start,
                          //           children: <Widget>[
                          //             const SizedBox(
                          //               height: 10,
                          //             ),
                          //             Text(
                          //               snapshot
                          //                   .data!.data!.shifts![0].shiftName
                          //                   .toString(),
                          //               style: GoogleFonts.poppins(
                          //                   fontWeight: FontWeight.w500,
                          //                   color: Colors.black),
                          //             ),
                          //             const SizedBox(
                          //               height: 15,
                          //             ),
                          //             Row(
                          //               children: <Widget>[
                          //                 Image.asset(
                          //                   'images/time_bw.png',
                          //                   height: 14,
                          //                   width: 13,
                          //                 ),
                          //                 const SizedBox(
                          //                   width: 5,
                          //                 ),
                          //                 Text(
                          //                   DateTime.parse(snapshot.data!.data!
                          //                               .shifts![0].startTime
                          //                               .toString())
                          //                           .toLocal()
                          //                           .hour
                          //                           .toString() +
                          //                       "${":"}" +
                          //                       DateTime.parse(snapshot
                          //                               .data!
                          //                               .data!
                          //                               .shifts![0]
                          //                               .startTime
                          //                               .toString())
                          //                           .toLocal()
                          //                           .minute
                          //                           .toString(),
                          //                   style: GoogleFonts.poppins(
                          //                       color: Color(0xffBCBCBC),
                          //                       fontSize: 11),
                          //                 ),
                          //                 const Icon(
                          //                   Icons.location_on,
                          //                   color: Color(0xffBCBCBC),
                          //                 ),
                          //                 Text(
                          //                   snapshot.data!.data!.shifts![0]
                          //                       .duty!.venue
                          //                       .toString(),
                          //                   style: GoogleFonts.poppins(
                          //                       color: Color(0xffBCBCBC),
                          //                       fontSize: 11),
                          //                 )
                          //               ],
                          //             )
                          //           ],
                          //         ),
                          //         const Icon(
                          //           Icons.arrow_forward_ios_rounded,
                          //           color: Color(0xff0d76d3),
                          //         ),
                          //         const SizedBox(),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          Text(
                            'Upcoming Duties',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff0D76D3),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.separated(
                              separatorBuilder: (context, int index) {
                                return SizedBox(
                                  height: 10,
                                );
                              },
                              shrinkWrap: true,
                              primary: false,
                              itemCount: snapshot.data!.data!.shifts!.length,
                              itemBuilder: (context, index) {
                                final startTime = DateTime.parse(snapshot
                                    .data!.data!.shifts![index].startTime
                                    .toString());
                                final endTime = DateTime.parse(snapshot
                                    .data!.data!.shifts![index].endTime
                                    .toString());
                                return DutyCard(
                                    onTap: () {
                                      provider.updateShiftID(snapshot
                                          .data!.data!.shifts![index].sId
                                          .toString());
                                      // setState(() {
                                      //   shiftID = snapshot
                                      //       .data!.data!.shifts![index].sId
                                      //       .toString();
                                      // });
                                      log(provider.shiftID.toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MapRender()));
                                    },
                                    dutyName: snapshot
                                        .data!.data!.shifts![index].shiftName
                                        .toString(),
                                    location: snapshot
                                        .data!.data!.shifts![index].duty!.venue
                                        .toString(),
                                    timePeriod:
                                        "${startTime.hour} - ${endTime.hour}",
                                    flag: "High",
                                    date: DateTime.parse(snapshot.data!.data!
                                                .shifts![index].startTime
                                                .toString())
                                            .day
                                            .toString() +
                                        "/" +
                                        DateTime.parse(snapshot.data!.data!
                                                .shifts![index].startTime
                                                .toString())
                                            .month
                                            .toString());
                              })
                        ],
                      ),
                    ),
                  );
          }),
    );
  }
}
