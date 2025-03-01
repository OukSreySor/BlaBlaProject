import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/screens/rides/widgets/rides_tile.dart';

import '../../model/ride/ride.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';
import '../../utils/date_time_util.dart';
import 'widgets/ride_pref_card.dart';

class RidesScreen extends StatefulWidget {
  final RidePref initRidePref;
  const RidesScreen({super.key, required this.initRidePref});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {

  List<Ride> get matchingRides =>
      RidesService.getRidesFor(widget.initRidePref);
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RidePrefBar(ridePref: widget.initRidePref,),
          Expanded(
            child: ListView.builder(
              itemCount: matchingRides.length,
              itemBuilder: (context, index) => RidesTile(
                ride: matchingRides[index], 
                onPressed: (){}
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RidePrefBar extends StatelessWidget {
  final RidePref ridePref;
  const RidePrefBar({super.key, required this.ridePref});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ 
        Container(
          decoration: BoxDecoration(
            color: BlaColors.backgroundAccent,
            borderRadius:
                BorderRadius.circular(BlaSpacings.radius), 
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: BlaColors.iconLight,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        RidePrefCard(ridePref: ridePref),
      ]
    );
  }
}

