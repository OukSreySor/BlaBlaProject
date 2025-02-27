import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/animations_util.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';
import 'package:week_3_blabla_project/widgets/actions/bla_button.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';
import 'package:week_3_blabla_project/widgets/display/bla_text_field.dart';
import 'package:week_3_blabla_project/widgets/inputs/bla_location_picker.dart';
 
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
 
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
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
 
  // Function to swap locations
  void _swapLocations() {
    setState(() {
      Location? temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  void _openLocationPicker() {
    Navigator.of(context).push(
      AnimationUtils.createBottomToTopRoute(BlaLocationPicker(locations: fakeLocations))
    );
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Preferences'),
      ),
      body: SingleChildScrollView(  
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [ 
                      BlaTextField(
                        label: 'Leaving from', 
                        icon: Icons.location_on,
                        onTap: _openLocationPicker,
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: Icon(Icons.swap_vert, color: BlaColors.primary,),
                          onPressed: _swapLocations,
                        ),
                      ),
                    ] 
                  ), 
                  SizedBox(height: BlaSpacings.m),
                  BlaDivider(),
                  SizedBox(height: BlaSpacings.m),
                  BlaTextField(
                    label: 'Going to', 
                    icon: Icons.location_on,
                    onTap: _openLocationPicker,
                  ),
                  SizedBox(height: BlaSpacings.m),
                  BlaDivider(),
                  SizedBox(height: BlaSpacings.m),
                  BlaTextField(
                    label: DateTimeUtils.formatDateTime(departureDate), 
                    icon: Icons.calendar_today,
                  ),
                  SizedBox(height: BlaSpacings.m),
                  BlaDivider(),
                  SizedBox(height: BlaSpacings.m),
                  BlaTextField(
                    label: '$requestedSeats', 
                    icon: Icons.person,
                  ),
                  SizedBox(height: BlaSpacings.m),
                  BlaButton(
                    text: 'Search',
                    buttonType: ButtonType.primary,
                    onPressed: () {},
                    
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
}
