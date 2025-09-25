import 'dart:async';
import 'package:c2studio/Menu.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  double _height = 0;
  double _width = 0;

  @override
  void initState() {
    super.initState();

    // Inicia la animación después de un pequeño delay
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _height = 500;
        _width = 500;
      });
    });

    // Navega al menú después de 3 segundos
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => const Menu()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent.shade400,
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          height: _height,
          width: _width,
          child: const Hero(
            tag: "logo",
            child: Image(
              image: AssetImage("assets/logo.png")
            ),
          ),
        ),
      ),
    );
  }
}