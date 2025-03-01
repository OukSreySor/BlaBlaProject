import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/animations_util.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';
import 'package:week_3_blabla_project/widgets/actions/bla_button.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';
import 'package:week_3_blabla_project/screens/ride_pref/widgets/rides_pref_input_tile.dart';
import 'package:week_3_blabla_project/widgets/inputs/bla_location_picker.dart';
import 'package:week_3_blabla_project/widgets/inputs/bla_rides_tile.dart';
 
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../rides/rides_screen.dart';
 
///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;


  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();

    if (widget.initRidePref != null) {
      departure = widget.initRidePref?.departure;
      arrival = widget.initRidePref?.arrival;
      departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
      requestedSeats = widget.initRidePref?.requestedSeats ?? 1;

    } else {
      departure = null;
      departureDate = DateTime.now();
      arrival = null;
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
 
 
  // Function to swap locations
  void swapLocations() {
    setState(() {
      if (departure != null && arrival != null) {
        Location? temp = departure;
        departure = arrival;
        arrival = temp;
      }
      
    });
  }

  void onDeparturePressed() async {
    // 1- Select a departure location
    Location? selectedDepartureLocation = await Navigator.of(context).push<Location>(
        AnimationUtils.createBottomToTopRoute(BlaLocationPicker(locations: departure,)));
        AnimationUtils.createBottomToTopRoute(BlaLocationPicker(locations: departure,));

    // 2- Update the form 
    if (selectedDepartureLocation != null) {
      setState(() {
        departure = selectedDepartureLocation;
      });
    }
  }

  void onArrivalPressed() async {
    // 1- Select a arrival location
    Location? selectedArrivalLocation = await Navigator.of(context).push<Location>(
        AnimationUtils.createBottomToTopRoute(BlaLocationPicker(locations: arrival,)));

    // 2- Update the form
    if (selectedArrivalLocation != null) {
      setState(() {
        arrival = selectedArrivalLocation;
      });
    }
  }

  void onSubmit() {
    if (departure != null && arrival != null) {
      RidePref newRidePref = RidePref(
        departure: departure!, 
        departureDate: departureDate, 
        arrival: arrival!, 
        requestedSeats: requestedSeats
      );

      Navigator.of(context).push(AnimationUtils.createBottomToTopRoute(RidesScreen(initRidePref: newRidePref,)));
    }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  
  String get departureLabel => departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";

  bool get showDeparturePLaceHolder => departure == null;
  bool get showArrivalPLaceHolder => arrival == null;

  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get switchVisible => arrival != null && departure != null;

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
       
        children:[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), 
              color: BlaColors.white,
            ),
          
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RidesPrefInputTile(
                    isPlaceHolder: showDeparturePLaceHolder,
                    label: departureLabel, 
                    icon: Icons.location_on,
                    onTap: onDeparturePressed,
                    rightIcon: switchVisible ? Icons.swap_vert : null, onRightIconPressed: switchVisible? swapLocations: null,
                  ), 
                  SizedBox(height: BlaSpacings.m),
                  RidesPrefInputTile(
                    isPlaceHolder: showArrivalPLaceHolder,
                    label: arrivalLabel, 
                    icon: Icons.location_on,
                    onTap: onArrivalPressed,
                  ),
                  SizedBox(height: BlaSpacings.m),
                  RidesPrefInputTile(
                    label: dateLabel, 
                    icon: Icons.calendar_month,
                    onTap: () {},
                  ),
                  SizedBox(height: BlaSpacings.m),
                  
                  RidesPrefInputTile(
                    label: numberLabel, 
                    icon: Icons.person,
                    onTap: () {},
                  ),
                  SizedBox(height: BlaSpacings.m),
                  
                ],
              ),
            
            ),
          ),
          BlaButton(
            text: 'Search',
            buttonType: ButtonType.primary,
            onPressed: onSubmit,
          ),
          
        ],
      );
    
    
  }
  
}
