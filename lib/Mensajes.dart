
import 'package:c2studio/photoUpload.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class message extends StatefulWidget {
  const message({super.key});

  @override
  State<message> createState() => _messageState();
}

// ignore: camel_case_types
class _messageState extends State<message> {
// ignore: non_constant_identifier_names, unused_field
final List<Map<String, String>> _items = [
    {'unidad': 'Unidad 1', 'materia': 'Matemáticas'},
    {'unidad': 'Unidad 2', 'materia': 'Física'},
  ];
// ignore: unused_field
final String _query = '';
// ignore: unused_field
final TextEditingController _searchController = TextEditingController();

@override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
// ignore: unused_element
List<Map<String, String>> get _filteredItems {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return _items;
    return _items.where((item) {
      final unidad = item['unidad']!.toLowerCase();
      final materia = item['materia']!.toLowerCase();
      return unidad.contains(q) || materia.contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PhotoUpload(); 
              },
            ),
          );
        },
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}