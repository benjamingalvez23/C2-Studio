import 'package:c2studio/ejercicio.dart';
import 'package:c2studio/teoria.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:c2studio/models/unidades.dart';

class Temario extends StatelessWidget {
  final InfoTemario temario;
  const Temario({super.key, required this.temario});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                temario.imagen,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                    Container(
                      color: Colors.grey[300],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calculate, size: 40, color: Colors.grey[600]),
                          const SizedBox(height: 8),
                          Text(
                            temario.nombre,
                            style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.teal,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              temario.nombre,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetalleUnidad(unidad: temario.unidad),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Abrir", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class CartUnidad extends StatelessWidget {
  const CartUnidad({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Temario - Cálculo II',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 230,
              child: ListView.builder(
                itemCount: carta.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) {
                  final temario = carta[index];
                  return Temario(temario: temario);
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class DetalleUnidad extends StatelessWidget {
  final Unidad unidad;
  const DetalleUnidad({super.key, required this.unidad});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(unidad.titulo.split(':')[0]),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Título completo
          Center(
            child: Text(
              unidad.titulo,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),

          TimelineTile(
            alignment: TimelineAlign.start, 
            isFirst: true,
            indicatorStyle: const IndicatorStyle(
              width: 40,
              height: 40,
              color: Colors.black,
              padding: EdgeInsets.all(8),
              indicator: Icon(Icons.info, color: Colors.white, size: 20),
            ),
            endChild: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '¿De qué trata?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    unidad.descripcion,
                    style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),

          TimelineTile(
            alignment: TimelineAlign.start,
            indicatorStyle: const IndicatorStyle(
              width: 40,
              height: 40,
              color: Colors.green,
              padding: EdgeInsets.all(8),
              indicator: Icon(Icons.school, color: Colors.white, size: 20),
            ),
            endChild: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📚 Lo que aprenderás:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...unidad.temas.map((tema) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '• ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            tema,
                            style: const TextStyle(fontSize: 14, height: 1.4,color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),

          TimelineTile(
            alignment: TimelineAlign.start,
            isLast: true,
            indicatorStyle: const IndicatorStyle(
              width: 40,
              height: 40,
              color: Colors.orange,
              padding: EdgeInsets.all(8),
              indicator: Icon(Icons.build, color: Colors.white, size: 20),
            ),
            endChild: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🔧 En la práctica:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    unidad.practica,
                    style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Ahora navega a la pantalla de teoría separada
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => teoria(),
                    ),
                  );
                },
                icon: const Icon(Icons.book),
                label: const Text('Teoría'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Ahora navega a la pantalla de ejercicios separada
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ejercicios(),
                    ),
                  );
                },
                icon: const Icon(Icons.quiz),
                label: const Text('Ejercicios'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}