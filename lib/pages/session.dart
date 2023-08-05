import 'package:flutter/material.dart';

class Session extends StatelessWidget {
  final String child;

  Session({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Container(
        // padding: EdgeInsets.all(15.0),
        // width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: const BoxDecoration(
            color: Color(0xFF3b3b3b),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            boxShadow: [
              BoxShadow(
                blurRadius: 25.0,
                offset: Offset(
                  5,
                  5,
                ),
              )
            ]),
        child: Center(child: Text(child, style: TextStyle(color: Colors.white),))),
    );
  }
}
