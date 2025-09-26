import 'package:flutter/material.dart';

// ignore: camel_case_types
class teoria extends StatefulWidget {
  const teoria({super.key});

  @override
  State<teoria> createState() => _teoriaState();
}

// ignore: camel_case_types
class _teoriaState extends State<teoria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teoría'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'En esta sección se presentará la información de las fórmulas de las materias con explicaciones detalladas y ejemplos prácticos para facilitar el aprendizaje',
            style: TextStyle(color: Colors.black, fontSize: 50),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}