import 'package:Trackpatrol/constants/widgets/flagWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRender extends StatefulWidget {
  const MapRender({super.key});

  @override
  State<MapRender> createState() => _MapRenderState();
}

class _MapRenderState extends State<MapRender> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        bottomSheet: MapBottomContainer(
            date: '07/07/2023',
            timePeriod: '00:00 am - 09:00 am',
            location: 'Location'),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}

class MapBottomContainer extends StatefulWidget {
  const MapBottomContainer(
      {super.key,
      required this.date,
      required this.timePeriod,
      required this.location});
  final String date;
  final String timePeriod;
  final String location;

  @override
  State<MapBottomContainer> createState() => _MapBottomContainerState();
}

class _MapBottomContainerState extends State<MapBottomContainer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          height: 276,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Text(
                'Bandobast Details',
                style:
                    GoogleFonts.poppins(fontSize: 16, color: Color(0xffa9a9a9)),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Image.asset(
                    'images/date.png',
                    height: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.date,
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Image.asset(
                    'images/timePeriod.png',
                    height: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.timePeriod,
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Image.asset(
                    'images/loc.png',
                    height: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.location,
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ButtonForBottomSheet(
                    title: 'Check location',
                    color: Colors.white,
                    textColor: Color(0xff0d76d3),
                  ),
                  ButtonForBottomSheet(
                      title: 'Start',
                      color: Color(0xff0d76d3),
                      textColor: Colors.white)
                ],
              ),
            ],
          ),
        ),
        Positioned(
            top: 80,
            left: 300,
            child: FlagContainer(flag: 'High', flagColor: Colors.red))
      ],
    );
  }
}

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
