import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_app_flutter/cards/exerciseItem_card.dart';


class ExerciseList extends StatefulWidget {
  const ExerciseList({super.key});

  @override
  State<ExerciseList> createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

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
                  return Text("Something went wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                final data = snapshot.requireData;

                return ListView.builder(
                  itemCount: data.size,
                  itemBuilder: (context, index) {
                    return ExerciseItem(textChild: data.docs[index]["label"]);
                  },
                );
              },)
          )
        ],
      ),
    );
  }
}
