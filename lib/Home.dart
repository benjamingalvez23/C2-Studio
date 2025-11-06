import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:table_calendar/table_calendar.dart';

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

DateTime today = DateTime.now();

// ignore: unused_element
void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    
    if (!isSameDay(today, selectedDay)) { 
      setState(() {
        today = selectedDay;
       
      });
    }
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
          Text("Canlendario"),
          // ignore: avoid_unnecessary_containers
          Container(
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 43,
            headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
             availableGestures: AvailableGestures.all,
              focusedDay: today, 
              firstDay: DateTime.utc(2010,11,5),
               lastDay: DateTime.utc(2030,3,14),
              selectedDayPredicate: (day)=> isSameDay(day, today),
              onDaySelected: _onDaySelected,
            ),
          ),
        ]
      ),
    );
    

  }
}