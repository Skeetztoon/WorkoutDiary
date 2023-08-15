import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';

class ExerciseCard extends StatefulWidget {
  final List<String> dropdownValues;
  final int index;
  const ExerciseCard({
    required this.dropdownValues,
    required this.index,
  });

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  int _currentSetsNumberPickerValue = 3;
  int _currentRepsNumberPickerValue = 10;

  String? selectedExersice;

  // GPT
  String replaceWordBetweenPipes(String originalString, String word) {
    int start = originalString.indexOf('|');
    int end = originalString.indexOf('|', start + 1);

    if (start != -1 && end != -1) {
      String prefix = originalString.substring(0, start + 1);
      String suffix = originalString.substring(end);
      return prefix + word + suffix;
    }

    return originalString;
  }

  String replaceWordAfterThirdPipe(String originalString, String word) {
    List<String> parts = originalString.split('|');

    if (parts.length >= 3) {
      parts[2] = word;
      return parts.join('|');
    }

    return originalString;
  }
  //

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
                const CircularProgressIndicator();
              } else {
                final exercises = snapshot.data?.docs.reversed.toList();

                for (var exercise in exercises!) {
                  exerciseItems.add(
                    DropdownMenuItem(
                      value: exercise["Label"],
                      child: Text(
                        exercise["Label"],
                        style: const TextStyle(
                            color: Colors.white, fontSize: 25),
                      ),
                    ),
                  );
                }
              }
              return DropdownButton(
                underline: Container(),
                dropdownColor: const Color(0xFF3b3b3b),
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
                    widget.dropdownValues[widget.index] = selectedExersice!;
                    widget.dropdownValues[widget.index] =
                        widget.dropdownValues[widget.index] +
                            '\|$_currentSetsNumberPickerValue' +
                            '\|$_currentRepsNumberPickerValue';
                  });
                },
              );
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
              onChanged: (value) {
                setState(() {
                  _currentSetsNumberPickerValue = value;
                  widget.dropdownValues[widget.index] =
                      replaceWordBetweenPipes(
                          widget.dropdownValues[widget.index],
                          _currentSetsNumberPickerValue.toString());
                });
              },
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
              onChanged: (value) {
                setState(() {
                  _currentRepsNumberPickerValue = value;
                  widget.dropdownValues[widget.index] =
                      replaceWordAfterThirdPipe(
                          widget.dropdownValues[widget.index],
                          _currentRepsNumberPickerValue.toString());
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
