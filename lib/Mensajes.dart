import 'package:c2studio/photoUpload.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class message extends StatefulWidget {
  const message({super.key});

  @override
  State<message> createState() => _messageState();
}

class _messageState extends State<message> {
  String _query = '';
  final TextEditingController _searchController = TextEditingController();
  late DatabaseReference _dbRef;
  
  List<Map<String, dynamic>> _todasLasPublicaciones = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    try {
      _dbRef = FirebaseDatabase.instance.ref('publicaciones');
      _cargarPublicaciones();
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al inicializar Firebase: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _cargarPublicaciones() {
    try {
      _dbRef.onValue.listen((event) {
        try {
          final data = event.snapshot.value;
          final List<Map<String, dynamic>> publicaciones = [];

          if (data != null && data is Map) {
            data.forEach((key, value) {
              try {
                if (value is Map) {
                  publicaciones.add({
                    'id': key.toString(),
                    'titulo': value['titulo']?.toString() ?? 'Sin título',
                    'descripcion': value['descripcion']?.toString() ?? '',
                    'unidad': value['unidad']?.toString() ?? 'Sin unidad',
                    'imagenUrl': value['imagenUrl']?.toString() ?? '',
                    'fecha': value['fecha']?.toString() ?? DateTime.now().toIso8601String(),
                  });
                }
              } catch (e) {
                print('Error al procesar publicación: $e');
              }
            });
          }

          // Ordenar por fecha (más recientes primero)
          publicaciones.sort((a, b) {
            try {
              final fechaA = DateTime.parse(a['fecha']);
              final fechaB = DateTime.parse(b['fecha']);
              return fechaB.compareTo(fechaA);
            } catch (e) {
              return 0;
            }
          });

          if (mounted) {
            setState(() {
              _todasLasPublicaciones = publicaciones;
              _isLoading = false;
              _errorMessage = null;
            });
          }
        } catch (e) {
          if (mounted) {
            setState(() {
              _errorMessage = 'Error al cargar publicaciones: $e';
              _isLoading = false;
            });
          }
        }
      }, onError: (error) {
        if (mounted) {
          setState(() {
            _errorMessage = 'Error de conexión: $error';
            _isLoading = false;
          });
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error al iniciar listener: $e';
          _isLoading = false;
        });
      }
    }
  }

  List<Map<String, dynamic>> get _filteredItems {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return _todasLasPublicaciones;

    return _todasLasPublicaciones.where((item) {
      final unidad = item['unidad']?.toLowerCase() ?? '';
      final titulo = item['titulo']?.toLowerCase() ?? '';
      final descripcion = item['descripcion']?.toLowerCase() ?? '';
      
      return unidad.contains(q) || 
             titulo.contains(q) || 
             descripcion.contains(q);
    }).toList();
  }

  String _formatearFecha(String fechaISO) {
    try {
      final fecha = DateTime.parse(fechaISO);
      final ahora = DateTime.now();
      final diferencia = ahora.difference(fecha);

      if (diferencia.inDays == 0) {
        if (diferencia.inHours == 0) {
          if (diferencia.inMinutes == 0) {
            return 'Ahora';
          }
          return 'Hace ${diferencia.inMinutes} min';
        }
        return 'Hace ${diferencia.inHours} h';
      } else if (diferencia.inDays == 1) {
        return 'Ayer';
      } else if (diferencia.inDays < 7) {
        return 'Hace ${diferencia.inDays} días';
      } else {
        return DateFormat('dd/MM/yyyy').format(fecha);
      }
    } catch (e) {
      return 'Fecha desconocida';
    }
  }

  void _mostrarDetallePublicacion(Map<String, dynamic> publicacion) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Barra superior
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            
            // Imagen
            Expanded(
              flex: 3,
              child: publicacion['imagenUrl'] != null && publicacion['imagenUrl'] != ''
                  ? Image.network(
                      publicacion['imagenUrl'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error, size: 50, color: Colors.red),
                              const SizedBox(height: 10),
                              Text('Error al cargar imagen', 
                                style: TextStyle(color: Colors.grey[600])),
                            ],
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Icon(Icons.image_not_supported, size: 100, color: Colors.grey)
                    ),
            ),
            
            // Información
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            publicacion['unidad'] ?? 'Sin unidad',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          _formatearFecha(publicacion['fecha'] ?? ''),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      publicacion['titulo'] ?? 'Sin título',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      publicacion['descripcion'] ?? 'Sin descripción',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _eliminarPublicacion(String id) async {
    try {
      await _dbRef.child(id).remove();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Publicación eliminada'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al eliminar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _confirmarEliminacion(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar publicación'),
        content: const Text('¿Estás seguro de que deseas eliminar esta publicación?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _eliminarPublicacion(id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar publicaciones...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _query = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
            ),
          ),

          // Contenido principal
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                size: 80,
                                color: Colors.red,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Error',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _errorMessage!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _isLoading = true;
                                    _errorMessage = null;
                                  });
                                  _cargarPublicaciones();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Reintentar'),
                              ),
                            ],
                          ),
                        ),
                      )
                    : _filteredItems.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _query.isEmpty ? Icons.folder_open : Icons.search_off,
                                  size: 80,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  _query.isEmpty
                                      ? 'No hay publicaciones aún'
                                      : 'No se encontraron resultados',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                if (_query.isEmpty) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    'Presiona el botón + para crear una',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: _filteredItems.length,
                            itemBuilder: (context, index) {
                              final item = _filteredItems[index];
                              
                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: InkWell(
                                  onTap: () => _mostrarDetallePublicacion(item),
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        // Imagen miniatura
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: item['imagenUrl'] != null && item['imagenUrl'] != ''
                                              ? Image.network(
                                                  item['imagenUrl'],
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Container(
                                                      width: 80,
                                                      height: 80,
                                                      color: Colors.grey[300],
                                                      child: const Icon(Icons.broken_image),
                                                    );
                                                  },
                                                )
                                              : Container(
                                                  width: 80,
                                                  height: 80,
                                                  color: Colors.grey[300],
                                                  child: const Icon(Icons.image),
                                                ),
                                        ),
                                        const SizedBox(width: 12),
                                        
                                        // Información
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item['titulo'] ?? 'Sin título',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                item['descripcion'] ?? '',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    child: Text(
                                                      item['unidad'] ?? 'N/A',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    _formatearFecha(item['fecha'] ?? ''),
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.grey[500],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        
                                        // Menú de opciones
                                        PopupMenuButton(
                                          icon: const Icon(Icons.more_vert),
                                          itemBuilder: (context) => [
                                            const PopupMenuItem(
                                              value: 'eliminar',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.delete, color: Colors.red),
                                                  SizedBox(width: 8),
                                                  Text('Eliminar'),
                                                ],
                                              ),
                                            ),
                                          ],
                                          onSelected: (value) {
                                            if (value == 'eliminar') {
                                              _confirmarEliminacion(item['id']);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final resultado = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PhotoUpload(),
              ),
            );
            
            if (resultado == true && mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Lista actualizada'),
                  duration: Duration(seconds: 1),
                ),
              );
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: $e'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}