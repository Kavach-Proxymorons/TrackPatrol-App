import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

showFailedDialog(BuildContext ctx) {
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
            "images/wrong.png",
            height: 96,
            width: 96,
          ),
          SizedBox(height: 10),
          Text(
            "Something went wrong, Try again",
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
                color: Color(0xffde2b2b),
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
