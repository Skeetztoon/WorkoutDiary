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
                              //STACK СЮДА
      body: tabs[_currentIndex],
      floatingActionButton: Container(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.pink,
              onPressed: () {
                showBottomSheet(context: context, builder: (BuildContext context) {
                  return SizedBox(
                   height: 400,
                    child: ElevatedButton(
                      child: Text("Close"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                });
              }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: _currentIndex == 0 ? Colors.pink : Colors.white,
                size: 35,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.calendar_month,
                color: _currentIndex == 1 ? Colors.pink : Colors.white,
                size: 35,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
