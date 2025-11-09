import 'package:c2studio/models/pantallaDeInfo.dart';
import 'package:c2studio/models/recordatorio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:table_calendar/table_calendar.dart';

// ignore: unused_import, duplicate_import
import 'package:c2studio/models/recordatorio.dart'; 
// ignore: unused_import, duplicate_import
import 'package:c2studio/models/pantallaDeInfo.dart'; 

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
 
DateTime today = DateTime.now();

// **DATOS SIMULADOS PARA CADA BOTÓN**
final User userLimites = User(id: '1', name: 'Límites', email: 'info@limites.com');
final User userDerivadas = User(id: '2', name: 'Derivadas', email: 'info@derivadas.com');
final User userEcuaciones = User(id: '3', name: 'Ecuaciones', email: 'info@ecuaciones.com');


// ignore: unused_element
void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    
    // Asegúrate de importar 'package:table_calendar/table_calendar.dart' para usar isSameDay
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
          const Text("Materia que debes Recordar",style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)), // Reemplaza por un título real si es necesario
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      // Navegación a la pantalla de información con los datos de Límites
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userLimites),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset('assets/limite.png', width: 50, height: 50),
                        const SizedBox(height: 4),
                        const Text('Limites'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: (){
                      // Navegación a la pantalla de información con los datos de Derivadas
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userDerivadas),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset('assets/funcion.png', width: 50, height: 50),
                        const SizedBox(height: 4),
                        const Text('Derivadas'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: (){
                      // Navegación a la pantalla de información con los datos de Ecuaciones
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userEcuaciones),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset('assets/formula.png', width: 50, height: 50),
                        const SizedBox(height: 4),
                        const Text('Ecuaciones'),
                      ],
                    ),
                  ),const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: (){
                      // Navegación a la pantalla de información con los datos de Ecuaciones
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userEcuaciones),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset('assets/formula.png', width: 50, height: 50),
                        const SizedBox(height: 4),
                        const Text('Sumatorias'),
                      ],
                    ),
                  )
                ]
              ),
            ),
          ),
          const SizedBox(height: 20),
          // ignore: avoid_unnecessary_containers
          Container(
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 43,
            headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
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