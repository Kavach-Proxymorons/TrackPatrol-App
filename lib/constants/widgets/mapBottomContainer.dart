import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'buttonForMapBottomSheet.dart';
import 'flagWidget.dart';

class MapBottomContainer extends StatefulWidget {
  const MapBottomContainer(
      {super.key,
      required this.date,
      required this.timePeriod,
      required this.location});
  final String date;
  final String timePeriod;
  final String location;

  @override
  State<MapBottomContainer> createState() => _MapBottomContainerState();
}

class _MapBottomContainerState extends State<MapBottomContainer> {
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
                  Text(
                    widget.date,
                    style: GoogleFonts.poppins(),
                  ),
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
                  Text(
                    widget.timePeriod,
                    style: GoogleFonts.poppins(),
                  ),
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
                  Text(
                    widget.location,
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ButtonForBottomSheet(
                    title: 'Check location',
                    color: Colors.white,
                    textColor: Color(0xff0d76d3),
                  ),
                  ButtonForBottomSheet(
                      title: 'Start',
                      color: Color(0xff0d76d3),
                      textColor: Colors.white)
                ],
              ),
            ],
          ),
        ),
        Positioned(
            top: 80,
            left: 300,
            child: FlagContainer(flag: 'High', flagColor: Colors.red))
      ],
    );
  }
}
