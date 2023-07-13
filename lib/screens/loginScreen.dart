import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:Trackpatrol/models/frame_data.dart';

Timer? timer;

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late PageController _pageController;
  int activePage = 0;
  List<FrameData> framedata = [
    FrameData(
        title: 'Stay Updated on Duties',
        description:
            'Vital duty assignments and personnel notifications shared',
        image: 'images/Frame1.png'),
    FrameData(
        title: 'Emergency SOS',
        description:
            'Quick access to emergency assistance and alerts for urgent situations.',
        image: 'images/Frame2.png'),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    timer = Timer.periodic(Duration(seconds: 8), (Timer t) => nextPage());
    activePage = 0;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void nextPage() {
    if (activePage == framedata.length - 1) {
      _pageController.animateToPage(0,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      setState(() {
        activePage = 0;
      });
    } else {
      _pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      setState(() {
        activePage++;
      });
    }
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black54 : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 30),
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/logo.png', height: 40),
                      SizedBox(width: 10),
                      Text(
                        'TRACKPATROL',
                        // style: ,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700, fontSize: 24),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    // width: MediaQuery.of(context).size.width,
                    height: 320,
                    child: PageView.builder(
                      itemCount: framedata.length,
                      pageSnapping: true,
                      controller: _pageController,
                      onPageChanged: (page) {
                        setState(() {
                          activePage = page;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Image.asset(framedata[index].image, height: 200),
                              SizedBox(height: 20),
                              Text(
                                framedata[index].title,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 26,
                                    color: Color(0xff0D76D3)),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  framedata[index].description,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: indicators(framedata.length, activePage),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          'Log-In',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 32,
                              color: Color.fromARGB(180, 7, 0, 0)),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          // width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: TextField(
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username',
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 50,
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        FilledButton(
                          onPressed: () {},
                          child: const Text('Submit'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xff0D76D3),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 100),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
