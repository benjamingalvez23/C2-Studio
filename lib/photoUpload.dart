import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PhotoUpload extends StatefulWidget {
  const PhotoUpload({super.key});

  @override
  State<PhotoUpload> createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  File? sampleImage;
  final formKey = GlobalKey<FormState>();
  String _myValue = ""; // Variable para guardar el valor del TextFormField

  // 1. Función para validar y guardar (movida fuera de build/enableUpload)
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      // ignore: avoid_print
      print('Form is valid. Value: $_myValue');
      return true;
    } else {
      return false;
    }
  }

  // 2. Función para obtener la imagen
  Future<void> getImage() async {
    // Usamos 'ImageSource.gallery' para seleccionar desde la galería
    final tempImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (tempImage != null) {
      setState(() {
        // Creamos un objeto File a partir de la ruta
        sampleImage = File(tempImage.path);
      });
    }
  }

  // 3. Widget para mostrar la imagen y el formulario
  Widget enableUpload() {
    // Se eliminó el 'Container' innecesario y se ajustaron los Paddings.
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Añadir padding al contenido
        child: Form(
          key: formKey,
          child: Column(
            // Estiramos los elementos para que usen el ancho disponible
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Muestra la imagen seleccionada
              Image.file(
                sampleImage!,
                // Usamos BoxFit.cover y ajustamos el alto para mejor visualización
                height: 300.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20.0),

              // Campo de texto para la descripción
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(), // Añadir borde para claridad
                ),
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Description is required'
                      : null;
                },
                onSaved: (value) {
                  _myValue = value!;
                },
              ),
              const SizedBox(height: 20.0),

              // 4. Se reemplazó RaisedButton (obsoleto) por ElevatedButton
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // Propiedad para el color de fondo (anteriormente 'color')
                  backgroundColor: Theme.of(context).primaryColor,
                  // Propiedad para el color del texto (anteriormente 'texteColor')
                  foregroundColor: Colors.white,
                  // Elevación
                  elevation: 10.0,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                ),
                onPressed: validateAndSave, // Llama a la función corregida
                child: const Text(
                  "Upload",
                  style: TextStyle(fontSize: 18.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Upload"), // Título del AppBar
        centerTitle: true,
      ),
      body: Center(
        child: sampleImage == null
            ? const Text("Tap the '+' button to select an image.")
            : enableUpload(),
      ),
      // Botón flotante para seleccionar la imagen
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: "Add Image",
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}