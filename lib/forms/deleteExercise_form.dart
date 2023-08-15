import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteExerciseForm extends StatefulWidget {

  final String exIndex;

  const DeleteExerciseForm({Key? key,  required this.exIndex}) : super(key: key);

  @override
  State<DeleteExerciseForm> createState() => _DeleteExerciseFormState();
}

class _DeleteExerciseFormState extends State<DeleteExerciseForm> {

  final _formKey = GlobalKey<FormState>();

  var exerciseLabel = "";

  @override
  Widget build(BuildContext context) {
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
              const Text("Are you sure you want to delete exercise?", style: TextStyle(color: Colors.white),),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Exercise deleted")));
                      final docExercise = FirebaseFirestore.instance.collection("ExercisesList").doc(widget.exIndex);
                      docExercise.delete();
                    }
                    Navigator.pop(context);
                  },
                  child: const Text("Delete"),
                ),
              )
            ],
          )),
    );
  }
}
