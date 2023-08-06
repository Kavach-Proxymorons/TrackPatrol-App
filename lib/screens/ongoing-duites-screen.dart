import 'package:flutter/material.dart';

class OngoingDuties extends StatefulWidget {
  const OngoingDuties({super.key});

  @override
  State<OngoingDuties> createState() => _OngoingDutiesState();
}

class _OngoingDutiesState extends State<OngoingDuties> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Ongoing Duties"),
      ),
    );
  }
}
