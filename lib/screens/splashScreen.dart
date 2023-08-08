import 'package:Trackpatrol/app.dart';
import 'package:Trackpatrol/models/login_model.dart';
import 'package:Trackpatrol/screens/dutiesPage.dart';
import 'package:Trackpatrol/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key, this.prefs});
  final prefs;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    var token_prefs = widget.prefs.getString('token');
    _controller = VideoPlayerController.asset('images/splash-video.mp4')
      ..initialize().then(
        (_) {
          _controller.play();
          _controller.setLooping(false);
          setState(
            () {
              Timer(
                const Duration(milliseconds: 3000),
                () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          token_prefs == null ? LoginScreen() : BuildTab(),
                    )),
              );
            },
          );
        },
      );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: AspectRatio(
            aspectRatio: 9.0 / 16.0,
            child: VideoPlayer(_controller),
          ),
        ),
      ),
    );
  }
}
