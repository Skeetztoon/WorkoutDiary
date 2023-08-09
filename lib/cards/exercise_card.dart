import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';

class ExerciseCard extends StatefulWidget {
  const ExerciseCard({super.key});

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}


int _currentNumberPickerValue = 3;

class _ExerciseCardState extends State<ExerciseCard> {

  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          DropdownButton(
            style: const TextStyle(color: Colors.white, fontSize: 25),
            dropdownColor: const Color(0xFF3b3b3b),
            value: dropdownValue,
              icon: const Visibility(
                visible: false,
                child: Icon(Icons.arrow_downward),
              ),
              hint: const Text(
                "TAP TO CHANGE",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              items: const [
                DropdownMenuItem<String>(
                  value: "Arm",
                  child: Text("Arm"),
                ),
                DropdownMenuItem<String>(
                  value: "Leg",
                  child: Text("Leg"),
                )
              ],
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                });
              }),
          // TextField(
          //   decoration:
          //       new InputDecoration(labelText: "Enter your number"),
          //   keyboardType: TextInputType.number,
          //   inputFormatters: <TextInputFormatter>[
          //     FilteringTextInputFormatter.digitsOnly
          //   ], // Only numbers can be entered
          // ),
          SizedBox(width: 20,
            child: NumberPicker(
              value: _currentNumberPickerValue,
              minValue: 1,
              maxValue: 10,
              itemHeight: 25,
              textStyle: TextStyle(color: Colors.white.withOpacity(0.05)),
              selectedTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
              onChanged: (value) => setState(() => _currentNumberPickerValue = value),
            ),
          ),
          const Text("x", style: TextStyle(color: Colors.pink, fontSize: 24),),
          SizedBox(width: 20,
            child: NumberPicker(
              value: _currentNumberPickerValue,
              minValue: 1,
              maxValue: 10,
              itemHeight: 25,
              textStyle: TextStyle(color: Colors.white.withOpacity(0.05)),
              selectedTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
              onChanged: (value) => setState(() => _currentNumberPickerValue = value),
            ),
          ),
        ],
      ),
    );
  }
}
