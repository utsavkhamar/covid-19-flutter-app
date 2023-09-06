import 'dart:async';

import 'package:covid19/view/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void initState() {
    super.initState();

    Timer(
        const Duration(seconds: 5),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WorldStateScreen())));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                      angle: _animationController.value * 2.0 * math.pi,
                      child: const Center(
                          child: Image(
                        image: AssetImage('images/virus.png'),
                      )));
                }),
            const SizedBox(
              height: 100,
            ),
            Text(
              "Covid 19\nTracking App",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  color: const Color(0xFF0A6441), fontSize: 25,
              ),
            )
          ],
        ),
      ),
    );
  }
}
