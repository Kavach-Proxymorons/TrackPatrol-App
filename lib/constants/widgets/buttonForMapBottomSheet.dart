import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonForBottomSheet extends StatefulWidget {
  const ButtonForBottomSheet(
      {super.key,
      required this.title,
      required this.color,
      required this.textColor});
  final String title;
  final Color color;
  final Color textColor;

  @override
  State<ButtonForBottomSheet> createState() => _ButtonForBottomSheetState();
}

class _ButtonForBottomSheetState extends State<ButtonForBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 49,
        width: 148,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xff0d76d3)),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: GoogleFonts.poppins(color: widget.textColor, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
