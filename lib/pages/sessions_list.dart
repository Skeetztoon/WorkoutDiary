import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_app_flutter/cards/session_card.dart';

class SessionsList extends StatefulWidget {
  const SessionsList({super.key});

  @override
  State<SessionsList> createState() => _SessionsListState();
}

class _SessionsListState extends State<SessionsList> {
  final Stream<QuerySnapshot> exercisesList =
      FirebaseFirestore.instance.collection("MyWorkouts").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff282828),
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              color: const Color(0xff282828),
              child: const Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    "YOUR SESSIONS",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("MyWorkouts").orderBy("Date", descending: true).snapshots(),
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
              ) {
                if (snapshot.hasError) {
                  return const Text("Something went wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                final data = snapshot.requireData;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.size,
                  itemBuilder: (context, index) {
                    return Session(
                        date: data.docs[index]["Date"],
                        exercises: data.docs[index]["Exercises"],
                        timer: data.docs[index]["Timer"],
                        index: data.docs[index].reference.id);
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
