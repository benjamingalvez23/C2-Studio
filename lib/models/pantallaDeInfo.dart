import 'package:flutter/material.dart';
// Importamos las clases User y Post
import 'recordatorio.dart'; 

// 1. Convertido a StatefulWidget
class UserProfileScreen extends StatefulWidget {
  final User user;
  const UserProfileScreen({super.key, required this.user});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

// 2. Agregamos SingleTickerProviderStateMixin
class _UserProfileScreenState extends State<UserProfileScreen> 
    with SingleTickerProviderStateMixin {
      
  // 3. Declaración del TabController
  late TabController _tabController;

  // Datos simulados (ya no se usa la lista de Posts, sino contenido directo)
  // Se mantienen para referencia si los necesitas en el futuro.
  List<Post> get userPosts {
    return [
      Post(title: '${widget.user.name} - Definición', content: 'Contenido de ejemplo 1.'),
      Post(title: '${widget.user.name} - Ejercicio 1', content: 'Contenido de ejemplo 2.'),
    ];
  }

  @override
  void initState() {
    super.initState();
    // Inicializa el TabController con 3 pestañas
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Es crucial limpiar el controller al salir de la pantalla
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Usamos widget.user para acceder a los datos de la clase superior
    final user = widget.user; 

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name), 
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Sección de Encabezado de Perfil (Mantenido)
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.black, 
            child: Column(
              children: <Widget>[
                const CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person, size: 40),
                ),
                const SizedBox(height: 10),
                Text(user.name, style: Theme.of(context).textTheme.headlineSmall),
                Text(user.email), 
                const SizedBox(height: 10),
              ],
            ),
          ),
          
          // 3. TAB BAR (Pestañas de Navegación)
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              indicatorWeight: 3,
              tabs: const [
                Tab(
                  icon: Icon(Icons.book),
                  text: 'Teoría',
                ),

                Tab(
                  icon: Icon(Icons.play_circle),
                  text: 'Video',
                ),
              ],
            ),
          ),
          
          // 4. TAB BAR VIEW (Contenido de las pestañas)
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Contenido Teoría
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Teoría de ${user.name}: Esta sección contendrá la explicación detallada y los conceptos fundamentales.', 
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // Contenido Fórmulas
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Fórmulas de ${user.name}: Aquí se mostrarán las ecuaciones y reglas matemáticas clave.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // Contenido Video
                const Center(
                  child: Text('Contenido de Video: Simulador de reproducción de video aquí.'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}