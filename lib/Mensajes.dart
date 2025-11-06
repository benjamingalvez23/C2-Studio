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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SecondPage(); 
              },
            ),
          );*/
        },
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}