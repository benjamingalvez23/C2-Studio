import 'package:c2studio/Cart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final List<Map<String, String>> promos = [
    {
      "titulo": "🔥 50% OFF en curso completo",
    },
    {
      "titulo": "📘 Pack de ejercicios gratis",
    },
    {
      "titulo": "⏰ Promoción por tiempo limitado",
    },
  ];

  int _currentPromo = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), _changePromo);
  }

  void _changePromo() {
    setState(() {
      _currentPromo = (_currentPromo + 1) % promos.length;
    });
    Future.delayed(const Duration(seconds: 3), _changePromo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),

          Text(
            'Bienvenido a C2 Studios',
            style: GoogleFonts.dmSerifDisplay(fontSize: 28, color: Colors.black),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Promo seleccionada: ${promos[_currentPromo]["titulo"]}"),
                          ),
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

          Expanded(child: CartPago()),
        ],
      ),
    );
  }
}