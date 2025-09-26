import 'package:c2studio/Mensajes.dart';
import 'package:c2studio/botones/barra_navegacion.dart';
import 'package:c2studio/Cart.dart';
import 'package:c2studio/Home.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget{
  const Menu({super.key});
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu>{
  int _selectedIndex = 0;

  void navigateBottomBar(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  final List<Widget>_pages= [
    const Start(),
    const CartUnidad(),
    const message()
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('C2 Studio', style: TextStyle(color: Colors.white, fontSize: 25),),
      ),
      bottomNavigationBar: Bottom(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
      
    );
  }
}
