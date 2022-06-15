import 'package:flutter/material.dart';

import '../../../controllers/station_controller.dart';

class OffDayCheckBox extends StatelessWidget {
  final int weekDay;
  final StationController stationController;
  OffDayCheckBox({required this.weekDay, required this.stationController});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => stationController.setWeekendString(weekDay.toString()),
        child: Row(children: [
          Checkbox(
            value: stationController.weekendString.contains(weekDay.toString()),
            onChanged: (bool? isActive) =>
                stationController.setWeekendString(weekDay.toString()),
            activeColor: Theme.of(context).primaryColor,
          ),
          Text(
            weekDay == 1
                ? 'monday'
                : weekDay == 2
                    ? 'tuesday'
                    : weekDay == 3
                        ? 'wednesday'
                        : weekDay == 4
                            ? 'thursday'
                            : weekDay == 5
                                ? 'friday'
                                : weekDay == 6
                                    ? 'saturday'
                                    : 'sunday',
          ),
        ]),
      ),
    );
  }
}
