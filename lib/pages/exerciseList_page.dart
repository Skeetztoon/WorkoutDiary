import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_app_flutter/cards/exerciseItem_card.dart';
import 'package:task_app_flutter/forms/createExercise_form.dart';

class ExerciseList extends StatefulWidget {
  const ExerciseList({super.key});

  @override
  State<ExerciseList> createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  @override

  final Stream<QuerySnapshot> exercisesList = FirebaseFirestore.instance.collection("ExercisesList").snapshots();

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
              child: StreamBuilder<QuerySnapshot>(stream: exercisesList, builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot,) {
                if (snapshot.hasError) {
                  return const Text("Something went wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                final data = snapshot.requireData;

                return ListView.builder(
                  itemCount: data.size,
                  itemBuilder: (context, index) {
                    return ExerciseItem(textChild: data.docs[index]["Label"], exerciseIndex: data.docs[index].reference.id);
                  },
                );
              },)
          ),
        ],
      ),

      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.pink,
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(context: context, builder: (BuildContext context) {
                return const AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  contentPadding: EdgeInsets.zero,
                  content: NewExerciseForm(),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
