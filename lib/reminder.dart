import 'package:flutter/material.dart';

// ignore: camel_case_types
class ReminderC1 extends StatefulWidget {
  const ReminderC1({super.key});

  @override
  State<ReminderC1> createState() => _ReminderC1State();
}

// ignore: camel_case_types
class _ReminderC1State extends State<ReminderC1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recordatorio C1"),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'En esta sección encontrarás un resumen de la materia que ya deberías manejar. Aquí se mostrarán los conceptos clave de forma clara y ordenada.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}