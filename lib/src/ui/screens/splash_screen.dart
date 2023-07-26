import 'dart:async';

import 'package:bloc_pattern_arc/src/ui/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: Lottie.network(
            'https://assets-v2.lottiefiles.com/a/fc7549d8-1188-11ee-af5c-8753440cb4c3/bp5lmAEVYU.json',
            repeat: false,
          ),
        ),
      ),
    );
  }
}
