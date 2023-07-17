import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

showConfirmDialog(BuildContext ctx) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    content: Container(
      height: 206,
      width: 309,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            "images/check.png",
            height: 96,
            width: 96,
          ),
          SizedBox(height: 10),
          Text(
            "Your duty is successfully started",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(ctx);
            },
            child: Container(
              height: 40,
              width: 170,
              decoration: BoxDecoration(
                color: Color(0xff0d76d3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "Okay",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
  showDialog(
      barrierDismissible: false,
      useRootNavigator: false,
      context: ctx,
      builder: (ctx) {
        return alert;
      });
}
