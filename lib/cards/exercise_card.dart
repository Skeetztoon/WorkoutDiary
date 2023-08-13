import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';

class ExerciseCard extends StatefulWidget {
  const ExerciseCard({super.key});

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  int _currentSetsNumberPickerValue = 3;
  int _currentRepsNumberPickerValue = 10;

  String? selectedExersice;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("ExercisesList")
                  .snapshots(),
              builder: (context, snapshot) {
                List<DropdownMenuItem> exerciseItems = [];
                if (!snapshot.hasData) {
                  // return const Text("Loading");
                  const CircularProgressIndicator();
                } else {
                  final exercises = snapshot.data?.docs.reversed.toList();

                  for (var exercise in exercises!) {
                    exerciseItems.add(
                      DropdownMenuItem(
                        value: exercise.id,
                        child: Text(exercise["Label"]),
                      ),
                    );
                  }
                }
                return DropdownButton(
                    hint: const Text(
                          "TAP TO CHANGE",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                    isExpanded: false,
                    value: selectedExersice,
                    items: exerciseItems,
                    onChanged: (exerciseValue) {
                      setState(() {
                        selectedExersice = exerciseValue;
                      });
                    });
              },
            ),

          SizedBox(
            width: 20,
            child: NumberPicker(
              value: _currentSetsNumberPickerValue,
              minValue: 1,
              maxValue: 10,
              itemHeight: 25,
              textStyle: TextStyle(color: Colors.white.withOpacity(0.05)),
              selectedTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 24),
              onChanged: (value) =>
                  setState(() => _currentSetsNumberPickerValue = value),
            ),
          ),
          const Text(
            "x",
            style: TextStyle(color: Colors.pink, fontSize: 24),
          ),
          SizedBox(
            width: 40,
            child: NumberPicker(
              value: _currentRepsNumberPickerValue,
              minValue: 1,
              maxValue: 30,
              itemHeight: 25,
              textStyle: TextStyle(color: Colors.white.withOpacity(0.05)),
              selectedTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 24),
              onChanged: (value) =>
                  setState(() => _currentRepsNumberPickerValue = value),
            ),
          ),


        ],
      ),
    );
  }
}
