import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app_flutter/pages/my_heat_map.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff282828),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Text(
              "WELCOME BACK",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: const BoxDecoration(
                  color: Colors.black87,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "${DateFormat("dd MMM yyyy").format(DateTime.now())}",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  FloatingActionButton.extended(//                       КНОПКА
                    label: Text(
                      'NEW WORKOUT',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    backgroundColor: Colors.pink,
                    icon: Icon(
                      Icons.add_circle_rounded,
                      color: Colors.black87,
                      size: 24.0,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width * 0.8,
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
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  MyHeatMap(),
                  Positioned(
                    top: 12.0,
                    child: Text("TRACKER",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
