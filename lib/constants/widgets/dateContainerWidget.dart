import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
