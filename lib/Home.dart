import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:c2studio/models/pantallaDeInfo.dart';
import 'package:c2studio/models/recordatorio.dart';
import 'package:c2studio/botones/barra_navegacion.dart'; // 👈 Importa tu nuevo widget

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  DateTime today = DateTime.now();

  final User userLimites = User(id: '1', name: 'Límites', email: 'info@limites.com');
  final User userDerivadas = User(id: '2', name: 'Derivadas', email: 'info@derivadas.com');
  final User userEcuaciones = User(id: '3', name: 'Ecuaciones', email: 'info@ecuaciones.com');
  final User userSumatorias = User(id: '4', name: 'Sumatorias', email: 'info@sumatorias.com');

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
          const SizedBox(height: 40),
          const Text(
            "Materia que debes Recordar",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // 🔹 SCROLL HORIZONTAL CON TUS NUEVAS CARTAS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CardButton(
                    image: 'assets/limite.png',
                    title: 'Límites',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userLimites),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  CardButton(
                    image: 'assets/funcion.png',
                    title: 'Derivadas',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userDerivadas),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  CardButton(
                    image: 'assets/formula.png',
                    title: 'Ecuaciones',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userEcuaciones),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  CardButton(
                    image: 'assets/sumatoria.png',
                    title: 'Sumatorias',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userSumatorias),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TableCalendar(
                locale: "en_US",
                rowHeight: 43,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                availableGestures: AvailableGestures.all,
                focusedDay: today,
                firstDay: DateTime.utc(2010, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                selectedDayPredicate: (day) => isSameDay(day, today),
                onDaySelected: _onDaySelected,
              ),
            ),
          ),
        ],
      ),
    );
  }
}