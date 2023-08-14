import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_app_flutter/cards/session_card.dart';


class SessionsList extends StatefulWidget {
  const SessionsList({super.key});

  @override
  State<SessionsList> createState() => _SessionsListState();
}

class _SessionsListState extends State<SessionsList> {

  final Stream<QuerySnapshot> exercisesList = FirebaseFirestore.instance.collection("MyWorkouts").snapshots();

  final List sessions = [
    1,
    2,
  ];

  int exercises = 2;

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
            "YOUR SESSIONS",
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
                    return Session(date: data.docs[index]["Date"], exercises: data.docs[index]["Exercises"], timer: data.docs[index]["Timer"], index: data.docs[index].reference.id);
                  },
                );
              },)
          ),
        ],
      ),
    );
  }
}
