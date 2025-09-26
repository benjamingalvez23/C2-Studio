import 'package:flutter/material.dart';

// ignore: camel_case_types
class ejercicios extends StatefulWidget {
  const ejercicios({super.key});

  @override
  State<ejercicios> createState() => _ejerciciosState();
}

// ignore: camel_case_types
class _ejerciciosState extends State<ejercicios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicios'),
        backgroundColor: Colors.orange,
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
            'En esta sección, los usuarios podrán subir sus ejercicios y resolver problemas prácticos, mientras que otros usuarios podrán dejar comentarios para ayudar a desarrollarlos de manera colaborativa',
            style: TextStyle(color: Colors.black, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}