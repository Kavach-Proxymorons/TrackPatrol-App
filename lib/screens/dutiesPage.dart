import 'dart:developer';

import 'package:Trackpatrol/dutyServices/getAlldutiesService.dart';
import 'package:Trackpatrol/maps/maps.dart';
import 'package:Trackpatrol/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/widgets/dutyWidget.dart';
import '../models/allDutiesmodel.dart';
import '../providers/locationProvider.dart';

bool dutyListEmpty = false;
String? shiftID;
Duration? timePer;

class DutiesPage extends StatefulWidget {
  const DutiesPage({super.key});

  @override
  State<DutiesPage> createState() => _DutiesPageState();
}

class _DutiesPageState extends State<DutiesPage> {
  late Future<AllDuties?> fetch;
  GetDutyclass getDutyclass = GetDutyclass();

  // Position? _position;
  // void _getUserloc() async {
  //   _position = await getUserCurrentLocation();
  //   setState(() {
  //     getLat = _position!.latitude;
  //     getLong = _position!.longitude;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getPrefs();

    Provider.of<LocationProvider>(context, listen: false).getposition();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: true);
    fetch = getDutyclass.getDuties(provider.token.toString());
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        actions: [
          Icon(Icons.account_circle_rounded),
          InkWell(
            onTap: () async {
              await provider.logout(context);
            },
            child: Text(
              'Logout',
              style: GoogleFonts.poppins(fontSize: 8),
            ),
          ),
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
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.data!.data!.shifts!.isEmpty) {
                dutyListEmpty = true;
              }
            }
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Starts in 1 Hour',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0D76D3),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapRender()));
                      },
                      child: Container(
                        height: 75,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff0D76D3)),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff0D76D3),
                                  border: Border.all(color: Color(0xff0D76D3)),
                                  borderRadius: BorderRadius.circular(19)),
                              height: 75,
                              width: 91,
                              child: Center(
                                child: Text(
                                  "09:45 am",
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: 5,
                            // ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Hussian Polling Activity',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    Image.asset(
                                      'images/time_bw.png',
                                      height: 14,
                                      width: 13,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '8 hours',
                                      style: GoogleFonts.poppins(
                                          color: Color(0xffBCBCBC),
                                          fontSize: 11),
                                    ),
                                    const Icon(
                                      Icons.location_on,
                                      color: Color(0xffBCBCBC),
                                    ),
                                    Text(
                                      'Location',
                                      style: GoogleFonts.poppins(
                                          color: Color(0xffBCBCBC),
                                          fontSize: 11),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xff0d76d3),
                            ),
                            const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                                setState(() {
                                  shiftID = snapshot
                                      .data!.data!.shifts![index].sId
                                      .toString();
                                });
                                log(shiftID.toString());
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
                              timePeriod: "${startTime.hour} - ${endTime.hour}",
                              time: "8 hours",
                              flag: "High",
                              date: DateTime.parse(snapshot
                                          .data!.data!.shifts![index].startTime
                                          .toString())
                                      .day
                                      .toString() +
                                  "/" +
                                  DateTime.parse(snapshot
                                          .data!.data!.shifts![index].startTime
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
