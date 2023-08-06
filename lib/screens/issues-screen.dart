import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Issues extends StatefulWidget {
  const Issues({super.key});

  @override
  State<Issues> createState() => _IssuesState();
}

class _IssuesState extends State<Issues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {},
        backgroundColor: Colors.red,
        child: Text(
          "SOS",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 22),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Report Issue",
          style: GoogleFonts.poppins(color: Colors.blue),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Issue", style: GoogleFonts.poppins(color: Colors.black)),
            TextFormField(
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                  hintText: "Description",
                  hintStyle: GoogleFonts.poppins(),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Submit",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    flex: -50,
                    child: Container(
                      padding: EdgeInsets.all(40),
                      child: Text("data"),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
