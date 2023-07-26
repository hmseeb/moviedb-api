import 'package:bloc_pattern_arc/src/ui/screens/home.dart';
import 'package:flutter/material.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.dark(
            primary: Colors.blue,
            secondary: Colors.red,
          )),
      home: const HomePage(),
    );
  }
}
