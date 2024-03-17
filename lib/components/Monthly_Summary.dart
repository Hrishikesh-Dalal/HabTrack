import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habits/date_time/Date_Time.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthlySummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(const Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey.shade400, // Use background color from theme
        textColor: Theme.of(context)
            .textTheme
            .bodyLarge!
            .color, // Use text color from theme
        // textColor: Colors.red,
        margin: EdgeInsets.all(5),
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 35,
        colorsets: {
          for (int i = 1; i <= 10; i++)
            i: Theme.of(context).primaryColor.withOpacity(
                i * 20 / 255), // Use primary color with varying opacity
        },
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
