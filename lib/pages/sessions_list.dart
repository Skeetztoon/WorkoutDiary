import 'package:flutter/material.dart';
import 'package:task_app_flutter/pages/session_card.dart';


class SessionsList extends StatefulWidget {
  const SessionsList({super.key});

  @override
  State<SessionsList> createState() => _SessionsListState();
}

class _SessionsListState extends State<SessionsList> {

  final List _sessions = [
    "Session 1",
    "Session 2",
    "Session 3",
    "Session 4",
    "Session 5",
  ];

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
              child: ListView.builder(
                  itemCount: _sessions.length, itemBuilder: (context, index) {
                  return Session(child: _sessions[index]);
                  })
              )
        ],
      ),
    );
  }
}
