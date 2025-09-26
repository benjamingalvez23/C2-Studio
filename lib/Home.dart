import 'package:c2studio/Cart.dart';
import 'package:c2studio/reminder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  final List<Map<String, String>> promos = [
    {
      "titulo": "Derivadas",
    },
    {
      "titulo": "Limites",
    },
    {
      "titulo": "Trigonometria",
    },
  ];

  int _currentPromo = 0;
  Timer? _timer; 

  @override
 void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) { 
        setState(() {
          _currentPromo = (_currentPromo + 1) % promos.length;
        });
      }
    });
  }

 @override
  void dispose() {
    _timer?.cancel(); 
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),

          Text(
            'Bienvenido a C2 Studios',
            style: GoogleFonts.dmSerifDisplay(fontSize: 30, color: Colors.black),
          ),
          const SizedBox(height: 20),
          Text(
            'Cosas que debes manejar antes de estudiar cálculo 2',
            style: GoogleFonts.dmSerifDisplay(fontSize: 20, color: Colors.black),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
            width: double.infinity, 
            height: 120, 
            child: Card(
              color: Colors.teal,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      promos[_currentPromo]["titulo"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ReminderC1()),
                      );
                    },
  child: const Text("Ver más"),
),
                  ],
                ),
              ),
            ),
          ),
            ),
          const SizedBox(height: 20),

          Expanded(child: CartUnidad()),
        ],
      ),
    );
  }
}