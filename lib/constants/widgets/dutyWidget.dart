import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dateContainerWidget.dart';
import 'flagWidget.dart';

class DutyCard extends StatefulWidget {
  final String dutyName;
  final String location;
  final String timePeriod;
  final String time;
  final String flag;
  final String date;

  const DutyCard(
      {super.key,
      required this.dutyName,
      required this.location,
      required this.timePeriod,
      required this.time,
      required this.flag,
      required this.date});

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
        Positioned(
            top: 120,
            left: 300,
            child: DateContainer(
              date: widget.date,
            ))
      ],
    );
  }
}
