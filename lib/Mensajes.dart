import 'package:flutter/material.dart';

// ignore: camel_case_types
class message extends StatefulWidget {
  const message({super.key});

  @override
  State<message> createState() => _messageState();
}

// ignore: camel_case_types
class _messageState extends State<message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('En esta sección, los usuarios podrán subir sus ejercicios, y los demás podrán dejar comentarios para ayudar a desarrollarlos', style: TextStyle(color: Colors.black, fontSize: 50),),
        ],
        
      ),
    );
  }
}