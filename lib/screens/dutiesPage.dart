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
                            Icon(
                              Icons.punch_clock_outlined,
                              color: Color(0xffBCBCBC),
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
              SizedBox(
                height: 10,
              ),
              Text(
                'Upcoming Duties',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Color(0xff0D76D3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DutyCard extends StatelessWidget {
  const DutyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
