import 'package:flutter/material.dart';

import '../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';
import '../../../utils/date_time_util.dart';

class RidePrefCard extends StatelessWidget {
  final RidePref ridePref;
  const RidePrefCard({
    super.key, 
    required this.ridePref,
  });

  String get departure => "Departure: ${ridePref.departure.name}" ;
  String get arrival =>  "Arrival: ${ridePref.arrival.name}";

  String get date => "Time: ${DateTimeUtils.formatDateTime(ridePref.departureDate)}";
  String get seats =>  "Number of Seats: ${ridePref.requestedSeats} passenger${ridePref.requestedSeats > 1 ? "s" : ""}";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap:(){},
        child: Card(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  departure,
                  style: BlaTextStyles.label.copyWith(color: BlaColors.textNormal)
                ),
                Text(
                  arrival,
                  style: BlaTextStyles.label.copyWith(color: BlaColors.textNormal)
                ),
                Text(
                  date,
                  style: BlaTextStyles.label.copyWith(color: BlaColors.textNormal)
                ),
                Text(
                  seats,
                  style: BlaTextStyles.label.copyWith(color: BlaColors.textNormal)
                ),
              ],
            ),
          ),
        ),
      );
  }
}