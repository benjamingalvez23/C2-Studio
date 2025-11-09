import 'package:flutter/material.dart';

class Temario extends StatelessWidget {
  const Temario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(
              'Uniadad 1',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      // Navegación a la pantalla de información con los datos de Límites
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userLimites),
                        ),
                      );*/
                    },
                    child: Column(
                      children: [
                        Image.asset('assets/unidad3.jpg', width: 50, height: 50),
                        const SizedBox(height: 4),
                        const Text('Temario Unidad 1'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: (){
                      // Navegación a la pantalla de información con los datos de Derivadas
                     /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userDerivadas),
                        ),
                      );*/
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
                     /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userEcuaciones),
                        ),
                      );*/
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
                       /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userEcuaciones),
                        ),
                      );*/
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
            Text(
              'Unidad 2',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      // Navegación a la pantalla de información con los datos de Límites
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userLimites),
                        ),
                      );*/
                    },
                    child: Column(
                      children: [
                        Image.asset('assets/unidad3.jpg', width: 50, height: 50),
                        const SizedBox(height: 4),
                        const Text('Temario Unidad 2'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: (){
                      // Navegación a la pantalla de información con los datos de Derivadas
                     /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userDerivadas),
                        ),
                      );*/
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
                     /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userEcuaciones),
                        ),
                      );*/
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
                       /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userEcuaciones),
                        ),
                      );*/
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
            Text(
              'Uniadad 3',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      // Navegación a la pantalla de información con los datos de Límites
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userLimites),
                        ),
                      );*/
                    },
                    child: Column(
                      children: [
                        Image.asset('assets/unidad3.jpg', width: 50, height: 50),
                        const SizedBox(height: 4),
                        const Text('Temario Unidad 3'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: (){
                      // Navegación a la pantalla de información con los datos de Derivadas
                     /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userDerivadas),
                        ),
                      );*/
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
                     /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userEcuaciones),
                        ),
                      );*/
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
                       /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: userEcuaciones),
                        ),
                      );*/
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
          ],
        ),
      ),
    );
  }
}
