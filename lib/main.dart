
import 'package:c2studio/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'C2 Studio',
      
      debugShowCheckedModeBanner: false,
      home: const Splashscreen(),
      theme: ThemeData(
       scaffoldBackgroundColor: Colors.tealAccent.shade400,
       brightness: Brightness.dark,
      ),
    );
  }
}

