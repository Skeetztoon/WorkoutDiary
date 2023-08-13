import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_app_flutter/cards/exercise_card.dart';



class NewWorkout extends StatefulWidget {
  const NewWorkout({super.key});

  @override
  State<NewWorkout> createState() => _NewWorkoutState();
}

class _NewWorkoutState extends State<NewWorkout> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  int exercises = 2;

  final List sessions = [
    1,
    2,
  ];

  final exercisesList = ["Arm", "Leg", "Shoulder"];
  List<DropdownMenuItem<String>> _createList() {
    return exercisesList
        .map<DropdownMenuItem<String>>(
          (e) => DropdownMenuItem(
        value: e,
        child: Text(e),
      ),
    )
        .toList();
  }


  ScrollController controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.95,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              border: Border.all(width: 10, color: const Color(0xFF3b3b3b)),
              color: const Color(0xff282828),
            ),
            child: Column(
              children: [
                const Text(
                  "NEW WORKOUT",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10,),

                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 500),
                  child: ListView.builder(
                    reverse: true,
                          shrinkWrap: true,
                      controller: controller,
                          itemCount: sessions.length, itemBuilder: (context, index) {
                    return const ExerciseCard();
                      }),
                ),

                FloatingActionButton.extended(
                  //                       КНОПКА
                  label: const Text(
                    'ADD',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  backgroundColor: Colors.pink,
                  icon: const Icon(
                    Icons.add_circle_rounded,
                    color: Colors.black87,
                    size: 24.0,
                  ),
                  onPressed: () {setState(() {
                    sessions.add(sessions[sessions.length-1]+1);
                    Timer(const Duration(milliseconds: 100), () {
                      controller.jumpTo(controller.position.maxScrollExtent);
                    });
                  });},
                ),
              ],
            ),
          ),
        ));
  }
}
