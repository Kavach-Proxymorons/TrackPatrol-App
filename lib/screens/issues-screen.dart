import 'package:Trackpatrol/constants/widgets/flagWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IssuesRender extends StatefulWidget {
  const IssuesRender({super.key});

  @override
  State<IssuesRender> createState() => _IssuesRenderState();
}

class _IssuesRenderState extends State<IssuesRender> {
  Future<void> _refreshData() async {}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: 50, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your issues",
            style: GoogleFonts.poppins(color: Colors.blue, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          RefreshIndicator.adaptive(
            onRefresh: _refreshData,
            child: ListView(
              shrinkWrap: true,
              children: [
                buildIssueListTile("Closed", "Sudden Rush Problem",
                    "65468465464", "Your issue is under review"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildIssueListTile(
    String flagStatus, String issueHeading, String issueNo, String response) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.blue, // Border color
        width: 1.0, // Border width
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 270,
          top: 30,
          child: FlagContainer(
              flag: flagStatus,
              flagColor: flagStatus == "Closed" ? Colors.grey : Colors.red),
        ),
        ListTile(
          title: Text(
            issueHeading,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          isThreeLine: true,
          dense: true,
          contentPadding: EdgeInsets.all(16),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Issue no : ${issueHeading}"),
              Text("Response : ${response}")
            ],
          ),
        ),
      ],
    ),
  );
}
