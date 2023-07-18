import 'package:Trackpatrol/dutyServices/getAlldutiesService.dart';
import 'package:Trackpatrol/maps/maps.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/widgets/dutyWidget.dart';
import '../dutyServices/getAlldutiesService.dart';
import '../models/allDutiesmodel.dart';
import 'loginScreen.dart';

bool dutyListEmpty = false;

class DutiesPage extends StatefulWidget {
  const DutiesPage({super.key});

  @override
  State<DutiesPage> createState() => _DutiesPageState();
}

class _DutiesPageState extends State<DutiesPage> {
  late Future<AllDuties?> fetch;
  GetDutyclass getDutyclass = GetDutyclass();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch = getDutyclass.getDuties(token!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        actions: const [
          Icon(Icons.account_circle_rounded),
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
                      onTap: () {
                        Navigator.push(
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
                        itemCount: snapshot.data!.data!.shifts!.length,
                        itemBuilder: (context, index) {
                          return DutyCard(
                              dutyName: snapshot
                                  .data!.data!.shifts![index].duty!.title
                                  .toString(),
                              location: snapshot
                                  .data!.data!.shifts![index].duty!.venue
                                  .toString(),
                              timePeriod: "00-00",
                              time: "8 hours",
                              flag: "High",
                              date: DateTime.parse(snapshot
                                      .data!.data!.shifts![index].startTime
                                      .toString())
                                  .day
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
