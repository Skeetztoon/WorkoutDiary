import 'package:flutter/material.dart';
import 'package:task_app_flutter/pages/sessions_list.dart';

import 'home_page.dart';

class InitPage extends StatefulWidget {
  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {

  int _currentIndex = 0;
  final tabs = [
    HomePage(),
    SessionsList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.pink,
        items: const [
          BottomNavigationBarItem(
            label: "HOME",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "SESSIONS",
            icon: Icon(Icons.calendar_month),
          )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}