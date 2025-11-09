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
  String _myValue = ""; 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        centerTitle: true,
      ),
      body: Center(
        child: sampleImage == null
            ? const Text("No image selected.")
            : enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: "Add Image",
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Future<void> getImage() async {
    var tempImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (tempImage != null) {
      setState(() {
        sampleImage = File(tempImage.path);
      });
    }
  }

  Widget enableUpload() {
    return Form( 
      key: formKey, 
      child: Column(
        children: [
          Image.file(sampleImage!, height: 300, width: 300),
          const SizedBox(height: 15.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Descripcion",
            ),
            validator: (value) {
              return value!.isEmpty ? "Ingresa una descripcion" : null;
            },
            onSaved: (value) {
              _myValue = value!; 
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save(); 
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Descripción: $_myValue"))
                );
              }
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }
}