import 'package:flutter/material.dart';

class C2 extends StatelessWidget {
  const C2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Página 1")),
      body: const Center(child: Text("Contenido de la Página 1")),
    );
  }
}