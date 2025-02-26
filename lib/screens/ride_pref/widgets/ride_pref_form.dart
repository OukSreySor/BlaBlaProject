import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';
import 'package:week_3_blabla_project/widgets/actions/bla_button.dart';
 
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

  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _arrivalController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();


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

      _departureController.text = departure?.name ?? '';
      _arrivalController.text = arrival?.name ?? '';
      _dateController.text = DateTimeUtils.formatDateTime(departureDate);
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

      _departureController.text = departure?.name ?? '';
      _arrivalController.text = arrival?.name ?? '';
    });
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
                      TextFormField(
                        controller: _departureController,
                        decoration: InputDecoration(
                          hintText: 'Leaving from',
                          border: UnderlineInputBorder(),  
                          prefixIcon: const Icon(Icons.location_on),  
                        ),
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
                  TextFormField(
                    controller: _arrivalController,
                    decoration: InputDecoration(
                      hintText: 'Goint to',
                      border: UnderlineInputBorder(),  
                      prefixIcon: const Icon(Icons.location_on),
                    ),
                    
                  ),
                  SizedBox(height: BlaSpacings.m),
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      hintText: 'Departure Date',
                      border: UnderlineInputBorder(),  
                      prefixIcon: const Icon(Icons.calendar_today),  
                    ),
                    
                  ),
                  SizedBox(height: BlaSpacings.m),
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      hintText: '1',
                      border: InputBorder.none,  
                      prefixIcon: const Icon(Icons.person),  
                    ),
                    
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
