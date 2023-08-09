import 'package:flutter/material.dart';
import 'package:task_app_flutter/cards/exerciseItem_card.dart';


class ExerciseList extends StatefulWidget {
  const ExerciseList({super.key});

  @override
  State<ExerciseList> createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {

  final List exercises = [
    "Bicep Cirls",
    "Pullups",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff282828),
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          const Text(
            "EXERCISES",
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: exercises.length, itemBuilder: (context, index) {
                return ExerciseItem(textChild: exercises[index],);
              })
          )
        ],
      ),
    );
  }
}
