import 'package:flutter/material.dart';
import 'package:task_app_flutter/pages/session.dart';

class SessionsList extends StatefulWidget {
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
      backgroundColor: Color(0xff282828),
      body: Column(
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
