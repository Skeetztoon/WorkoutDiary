import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewExerciseForm extends StatefulWidget {
  const NewExerciseForm({super.key});

  @override
  State<NewExerciseForm> createState() => _NewExerciseFormState();
}

class _NewExerciseFormState extends State<NewExerciseForm> {
  final _formKey = GlobalKey<FormState>();

  var exerciseLabel = "";

  @override
  Widget build(BuildContext context) {
    CollectionReference exercisesList =
        FirebaseFirestore.instance.collection("ExercisesList");
    return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          height: 200,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            border: Border.all(width: 10, color: const Color(0xFF3b3b3b)),
            color: const Color(0xff282828),
          ),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink)),
                      hintText: "Type your exercise here",
                      hintStyle: TextStyle(color: Colors.grey)
                    ),
                    onChanged: (value) {
                      exerciseLabel = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field is empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Exercise added")));

                          exercisesList
                              .add({"Label": exerciseLabel})
                              .then((value) => print("Exercise added"))
                              .catchError((error) => print("Failed to add exercise: $error"));
                        }
                        Navigator.pop(context);

                      },
                      child: const Text("Add"),
                    ),
                  )
                ],
              )),
        );
  }
}
