import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
