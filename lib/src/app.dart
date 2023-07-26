import 'package:bloc_pattern_arc/src/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:
            const ColorScheme.dark(), // Handle the possible null value here
      ),
      home: const SplashScreen(),
    );
  }
}
