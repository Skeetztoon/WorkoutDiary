import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  const MyHeatMap({super.key});

  @override
  Widget build(BuildContext context) {
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
      datasets: {
        DateTime(2023, 8, 1): 1,
        DateTime(2023, 8, 5): 1,
        DateTime(2023, 8, 12): 1,
        DateTime(2023, 8, 17): 1,
        DateTime(2023, 8, 30): 1,
      },
      // startDate: DateTime(2023, 8, 1),
      // endDate: DateTime(2023, 8, 31),
      colorsets: {
        1: Colors.pink,
      },
      onClick: (value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
      },
    );
  }
}