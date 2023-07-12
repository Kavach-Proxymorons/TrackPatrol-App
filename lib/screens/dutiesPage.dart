import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DutiesPage extends StatefulWidget {
  const DutiesPage({super.key});

  @override
  State<DutiesPage> createState() => _DutiesPageState();
}

class _DutiesPageState extends State<DutiesPage> {
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
      body: SingleChildScrollView(
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
              Container(
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
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Hussian Polling Activity',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'images/time_bw.png',
                              height: 14,
                              width: 13,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '8 hours',
                              style: GoogleFonts.poppins(
                                  color: Color(0xffBCBCBC), fontSize: 11),
                            ),
                            Icon(
                              Icons.location_on,
                              color: Color(0xffBCBCBC),
                            ),
                            Text(
                              'Location',
                              style: GoogleFonts.poppins(
                                  color: Color(0xffBCBCBC), fontSize: 11),
                            )
                          ],
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xff0d76d3),
                    ),
                    SizedBox(),
                  ],
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
              const DutyCard(
                dutyName: "Hussian Polling Activity",
                location: "Location",
                timePeriod: "00:00 am - 09:00 am",
                time: "8 hours",
                flag: "High",
                date: "10 April",
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DutyCard extends StatefulWidget {
  const DutyCard(
      {super.key,
      required this.dutyName,
      required this.location,
      required this.timePeriod,
      required this.time,
      required this.flag,
      required this.date});

  final String dutyName;
  final String location;
  final String timePeriod;
  final String time;
  final String flag;
  final String date;

  @override
  State<DutyCard> createState() => _DutyCardState();
}

class _DutyCardState extends State<DutyCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('images/1.png'),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.dutyName,
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Image.asset(
                    'images/loc.png',
                    height: 18,
                    width: 12,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.location,
                    style: GoogleFonts.poppins(fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Image.asset(
                    'images/timePeriod.png',
                    height: 18,
                    width: 12,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.timePeriod,
                    style: GoogleFonts.poppins(fontSize: 15),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Image.asset(
                    'images/time.png',
                    height: 18,
                    width: 12,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.time,
                    style: GoogleFonts.poppins(fontSize: 15),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              FlagContainer(flag: 'High', flagColor: Colors.red)
            ],
          ),
        ),
        const Positioned(
            top: 120,
            left: 300,
            child: DateContainer(
              date: '10 April',
            ))
      ],
    );
  }
}

class FlagContainer extends StatefulWidget {
  const FlagContainer({
    super.key,
    required this.flag,
    required this.flagColor,
  });
  final String flag;
  final Color flagColor;
  @override
  State<FlagContainer> createState() => _FlagContainerState();
}

class _FlagContainerState extends State<FlagContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 82,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: widget.flagColor,
      ),
      child: Center(
          child: Text(
        widget.flag,
        style: GoogleFonts.poppins(color: Colors.white),
      )),
    );
  }
}

class DateContainer extends StatefulWidget {
  const DateContainer({super.key, required this.date});
  final String date;
  @override
  State<DateContainer> createState() => _DateContainerState();
}

class _DateContainerState extends State<DateContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 62,
      width: 62,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xff0d76d3)),
      child: Center(
          child: Text(
        textAlign: TextAlign.center,
        softWrap: true,
        widget.date,
        style: GoogleFonts.poppins(color: Colors.white),
      )),
    );
  }
}
