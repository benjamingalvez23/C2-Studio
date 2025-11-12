import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

class PhotoUpload extends StatefulWidget {
  const PhotoUpload({super.key});

  @override
  State<PhotoUpload> createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  
  File? _imageFile;
  String? _unidadSeleccionada;
  bool _isLoading = false;

  final List<String> _unidades = ['Unidad 1', 'Unidad 2', 'Unidad 3'];

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  Future<void> _tomarFoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );
      
      if (photo != null) {
        setState(() {
          _imageFile = File(photo.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al tomar la foto: $e')),
        );
      }
    }
  }

  Future<void> _seleccionarDeGaleria() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );
      
      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al seleccionar la imagen: $e')),
        );
      }
    }
  }

  void _mostrarOpcionesImagen() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tomar foto'),
                onTap: () {
                  Navigator.pop(context);
                  _tomarFoto();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Seleccionar de galería'),
                onTap: () {
                  Navigator.pop(context);
                  _seleccionarDeGaleria();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _guardarPublicacion() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona una imagen')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final String titulo = _tituloController.text.trim();
      final String descripcion = _descripcionController.text.trim();
      final String unidad = _unidadSeleccionada!;
      
      // Subir imagen a Firebase Storage
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('publicaciones')
          .child(fileName);
      
      await storageRef.putFile(_imageFile!);
      final String imageUrl = await storageRef.getDownloadURL();
      
      // Guardar datos en Firebase Database
      final DatabaseReference dbRef = FirebaseDatabase.instance.ref('publicaciones');
      await dbRef.push().set({
        'titulo': titulo,
        'descripcion': descripcion,
        'unidad': unidad,
        'imagenUrl': imageUrl,
        'fecha': DateTime.now().toIso8601String(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Publicación guardada exitosamente!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true); // Retorna true para indicar que se guardó
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al guardar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Publicación'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sección de imagen
              GestureDetector(
                onTap: _mostrarOpcionesImagen,
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[400]!),
                  ),
                  child: _imageFile == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              size: 60,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Toca para agregar una imagen',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),

              // Campo Título
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  hintText: 'Ej: Límites y Continuidad',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa un título';
                  }
                  return null;
                },
                maxLength: 50,
              ),
              const SizedBox(height: 16),

              // Campo Descripción
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  hintText: 'Describe el contenido...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.description),
                  alignLabelWithHint: true,
                ),
                maxLines: 4,
                maxLength: 200,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa una descripción';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Selector de Unidad
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Unidad',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.category),
                ),
                value: _unidadSeleccionada,
                hint: const Text('Selecciona una unidad'),
                items: _unidades.map((String unidad) {
                  return DropdownMenuItem<String>(
                    value: unidad,
                    child: Text(unidad),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _unidadSeleccionada = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor selecciona una unidad';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Botón Guardar
              ElevatedButton(
                onPressed: _isLoading ? null : _guardarPublicacion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Publicar',
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}