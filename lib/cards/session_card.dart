import 'package:flutter/material.dart';

class Session extends StatelessWidget {
  final String index;
  final String date;
  final String timer;
  final List<dynamic> exercises;

  Session({required this.date, required this.exercises, required this.index, required this.timer});

  makeList() {
    String str = exercises.map((exercise) {
      exercise = exercise.replaceAll("|", " ");
      exercise = exercise.replaceRange(exercise.lastIndexOf(" "), exercise.lastIndexOf(" ") + 1, "x");
      exercise += "\n";
      return exercise;
    }).toString();
    str = str.replaceAll('(', "").replaceAll(')', "").replaceAll(', ', "");
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: "ListTile-Hero",
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              tileColor: const Color(0xFF3b3b3b),
              textColor: Colors.white,
              iconColor: Colors.white,
              title: Text(
                date,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              subtitle: Text('Time: "$timer"'),
              trailing: const Icon(Icons.remove_red_eye_outlined),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute<Widget>(builder: (BuildContext context) {
                  return Scaffold(
                    backgroundColor: const Color(0xff282828),
                    body: Center(
                      child: Hero(
                        tag: 'ListTile-Hero',
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            textColor: Colors.white,
                            tileColor: const Color(0xFF3b3b3b),
                            title: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                child: Text('Time spent: $timer',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20))),
                            subtitle: Text(
                              makeList(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                }));
              },
            )));
  }
}
