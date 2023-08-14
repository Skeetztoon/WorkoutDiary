import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:intl/intl.dart';

class MyHeatMap extends StatelessWidget {
  const MyHeatMap({super.key});

  @override
  Future<Map<DateTime, int>> getWorkoutDates() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('MyWorkouts').get();

    final Map<DateTime, int> workoutDates = {};

    snapshot.docs.forEach((doc) {
      final String dateString = doc.get('Date');
      final DateTime date = DateFormat('dd-MM-yyyy').parse(dateString);

      workoutDates[date] = 1;
    });
    return workoutDates;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<DateTime, int>>(
      future: getWorkoutDates(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return HeatMapCalendar(
            showColorTip: false,
            defaultColor: Colors.white,
            flexible: true,
            borderRadius: 30,
            fontSize: 20,
            weekFontSize: 15,
            monthFontSize: 0,
            textColor: Colors.black,
            colorMode: ColorMode.color,
            datasets: snapshot.data,
            initDate: DateTime(2023, 8, 1),
            colorsets: {
              1: Colors.pink,
            },
            onClick: (value) {},
          );
        }
        ;
      },
    );
  }
}
