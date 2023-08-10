import 'package:flutter/material.dart';
import 'package:task_app_flutter/forms/editExercise_form.dart';

class ExerciseItem extends StatelessWidget {
  final String textChild;
  final String exerciseIndex;

  ExerciseItem({required this.textChild, required this.exerciseIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          tileColor: const Color(0xFF3b3b3b),
          textColor: Colors.white,
          iconColor: Colors.white,
          // contentPadding: EdgeInsets.symmetric(horizontal: 20),
          // leading: FlutterLogo(size: 56.0),
          title: Text(
            textChild,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.edit_rounded,
                size: 20.0,
              ),
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      contentPadding: EdgeInsets.zero,
                      content: EditExerciseForm(initialString: textChild, exIndex: exerciseIndex, ),
                    );
                  },
                );
              },
            ),
          ])),
    );
  }
}
