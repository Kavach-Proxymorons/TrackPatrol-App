import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/authProvider.dart';
import '../services/issue-services.dart';

class Issues extends StatefulWidget {
  const Issues({super.key});

  @override
  State<Issues> createState() => _IssuesState();
}

class _IssuesState extends State<Issues> {
  late TextEditingController _descController;
  bool _isloading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _descController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    provider.getPrefs();
    String dropdownValue = 'Select Category';

    return Scaffold(
      bottomSheet: buildBottomSheet(),
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
            DropdownButton<String>(
              // Step 3.
              value: dropdownValue,
              // Step 4.
              items: <String>[
                'Select Category',
                'Internet Issue',
                'Network Issue',
                'Battery Issue',
                'Crowd Issue',
                'Others',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style:
                        GoogleFonts.poppins(fontSize: 15, color: Colors.grey),
                  ),
                );
              }).toList(),
              // Step 5.
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            Text("Description",
                style: GoogleFonts.poppins(color: Colors.black)),
            TextFormField(
              controller: _descController,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                  hintText: "I have a problem regarding...",
                  hintStyle: GoogleFonts.poppins(),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            ),
            SizedBox(
              height: 20,
            ),
            Visibility(
              visible: false,
              child: InkWell(
                onTap: () async {
                  setState(() {
                    _isloading = true;
                  });
                  var fetch = issuePost(
                      provider.token.toString(),
                      dropdownValue,
                      _descController.text,
                      provider.shiftID.toString());
                  setState(() {
                    _isloading = false;
                  });
                },
                child: Container(
                  height: 40,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: _isloading
                        ? CircularProgressIndicator()
                        : Text(
                            "Submit",
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildBottomSheet() {
  return Container(
    height: 203,
    width: double.infinity,
    padding: EdgeInsets.all(20),
    child: Column(
      children: [
        Text(
          "Press and hold button for 3 seconds",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Container(
              height: 60,
              width: 200,
              child: Text(
                "SOS Button will immidiately send a distress signal to the authority.",
                overflow: TextOverflow.visible,
                style: GoogleFonts.poppins(),
              ),
            ),
            SizedBox(width: 40),
            FloatingActionButton.large(
              backgroundColor: Colors.red,
              onPressed: () {},
              child: Text(
                "SOS",
                style: GoogleFonts.poppins(fontSize: 30),
              ),
            )
          ],
        ),
      ],
    ),
  );
}
