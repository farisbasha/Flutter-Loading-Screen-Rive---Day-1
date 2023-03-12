// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var animationList = ['Off'];
  var _isLoading = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = true;
        animationList = ['OffOn', 'Fire'];
      });
      Future.delayed(Duration(seconds: 6), () {
        setState(() {
          _isLoading = false;
          animationList = ['OnOff'];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            RiveAnimation.asset(
              'assets/fire.riv',
              animations: animationList,
              fit: BoxFit.fill,
            ),
            if (_isLoading)
              Positioned.fill(
                  bottom: 150,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedTextKit(animatedTexts: [
                      TypewriterAnimatedText(
                        'Loading...',
                        textStyle: GoogleFonts.rubikIso(
                            fontSize: 30.0, color: Colors.white),
                        speed: const Duration(milliseconds: 600),
                      ),
                    ]),
                  ))
          ],
        ));
  }
}
