import 'package:flutter/material.dart';
import 'package:task_app_flutter/pages/new_workout.dart';
import 'package:task_app_flutter/pages/sessions_list.dart';
import 'package:page_transition/page_transition.dart';

import 'home_page.dart';

class InitPage extends StatefulWidget {
  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  int _currentIndex = 0;
  final tabs = [
    const HomePage(),
    const SessionsList(),
  ];

  @override
  Widget build(BuildContext context) {

    Future<bool> showExitPopup() async {
      return await showDialog( //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xff282828),
          title: const Text('Exit App', style: TextStyle(color: Colors.white)),
          content: const Text('Do you want to exit an App?', style: TextStyle(color: Colors.white)),
          actions:[
            ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              onPressed: () => Navigator.of(context).pop(false),
              //return false when click on "NO"
              child:const Text('No'),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              onPressed: () => Navigator.of(context).pop(true),
              //return true when click on "Yes"
              child:const Text('Yes'),
            ),

          ],
        ),
      )??false; //if showDialouge had returned null, then return false
    }









  return WillPopScope(
  onWillPop: showExitPopup, //call function on back button press
  child:Scaffold(
                              //STACK СЮДА
      body: tabs[_currentIndex],
      floatingActionButton: Container(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(
              child: const Icon(Icons.add),
              backgroundColor: Colors.pink,
              onPressed: () {
                Navigator.push(context, PageTransition(
                  type: PageTransitionType.fade , duration: const Duration(milliseconds: 150),
                  child: const NewWorkout()
                ));
              }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
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
    ));
  }
}
