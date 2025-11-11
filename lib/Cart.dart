import 'package:c2studio/models/pantallaDeInfo.dart';
import 'package:flutter/material.dart';
import 'package:c2studio/botones/barra_navegacion.dart'; 

class Temario extends StatelessWidget {
  const Temario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUnidad(
                context,
                titulo: 'Unidad 1',
                botones: [
                  CardButton(
                    image: 'assets/unidad3.jpg',
                    title: 'Temario Unidad 1',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Abrir Temario Unidad 1')),
                      );
                    },
                  ),
                  CardButton(
                    image: 'assets/funcion.png',
                    title: 'Derivadas',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Abrir Derivadas')),
                      );
                    },
                  ),
                  CardButton(
                    image: 'assets/formula.png',
                    title: 'Ecuaciones',
                    onTap: () {},
                  ),
                  CardButton(
                    image: 'assets/sumatoria.png',
                    title: 'Sumatorias',
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _buildUnidad(
                context,
                titulo: 'Unidad 2',
                botones: [
                  CardButton(
                    image: 'assets/unidad3.jpg',
                    title: 'Temario Unidad 2',
                    onTap: () {},
                  ),
                  CardButton(
                    image: 'assets/funcion.png',
                    title: 'Derivadas',
                    onTap: () {},
                  ),
                  CardButton(
                    image: 'assets/formula.png',
                    title: 'Ecuaciones',
                    onTap: () {},
                  ),
                  CardButton(
                    image: 'assets/sumatoria.png',
                    title: 'Sumatorias',
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _buildUnidad(
                context,
                titulo: 'Unidad 3',
                botones: [
                  CardButton(
                    image: 'assets/unidad3.jpg',
                    title: 'Temario Unidad 3',
                    onTap: () {},
                  ),
                  CardButton(
                    image: 'assets/funcion.png',
                    title: 'Fundamentos de Series',
                    onTap: () {},
                  ),
                  CardButton(
                    image: 'assets/formula.png',
                    title: 'Criterios de Convergencia para Series',
                    onTap: () {
                     /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userDerivadas),
                        ),
                      );*/
                    },
                  ),
                  CardButton(
                    image: 'assets/sumatoria.png',
                    title: 'Series Alternadas',
                    onTap: () {
                     
                    },
                  ),
                  CardButton(
                    image: 'assets/sumatoria.png',
                    title: 'Series de Potencias',
                    onTap: () {
                      
                    },
                  ),
                  CardButton(
                    image: 'assets/sumatoria.png',
                    title: 'Series de Taylor y Maclaurin',
                    onTap: () {
                      
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Pequeña función auxiliar para evitar repetir tanto código
  Widget _buildUnidad(BuildContext context,
      {required String titulo, required List<Widget> botones}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: botones
                .map((b) => Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: b,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}