import 'package:flutter/material.dart';

class Session extends StatelessWidget {
  final String child;

  Session({required this.child});

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: "ListTile-Hero",
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListTile(
              shape: RoundedRectangleBorder(
                //<-- SEE HERE
                borderRadius: BorderRadius.circular(15.0),
              ),
              tileColor: const Color(0xFF3b3b3b),
              textColor: Colors.white,
              iconColor: Colors.white,
              // contentPadding: EdgeInsets.symmetric(horizontal: 20),
              // leading: FlutterLogo(size: 56.0),
              title: const Text(
                'Training at "Date"',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              subtitle: const Text('Time: "1:37"'),
              trailing: Icon(Icons.remove_red_eye_outlined),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute<Widget>(builder: (BuildContext context) {
                  return Scaffold(
                    backgroundColor: const Color(0xff282828),
                    body: Center(
                      child: Hero(
                        tag: 'ListTile-Hero',
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            textColor: Colors.white,
                            tileColor: const Color(0xFF3b3b3b),
                            title: Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Text('Time spent: 1:37',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20))),
                            subtitle: const Text(
                              'Pull-ups: 3x10 \nBicep cirls: 3xFailure',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
