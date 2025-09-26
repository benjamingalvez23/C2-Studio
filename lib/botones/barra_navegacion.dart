import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class Bottom extends StatelessWidget {
  void Function(int)? onTabChange;
   Bottom({super.key, required this.onTabChange});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GNav(
        backgroundColor: Colors.black,
        color: Colors.white,
        activeColor: Colors.white,
        tabBackgroundColor: Colors.grey.shade900,
        gap: 8,
        padding: EdgeInsets.all(16),
        onTabChange: (value) => onTabChange!(value),
        tabs: const [
          GButton(icon: Icons.home, text: 'Home', ),
          GButton(icon: Icons.search, text: 'Search',),
          GButton(icon: Icons.message , text:'Message',)
        ],
      );
  }
}