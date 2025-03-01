import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/screens/ride_pref/ride_pref_screen.dart';
import 'package:week_3_blabla_project/screens/ride_pref/widgets/ride_pref_form.dart';
import 'package:week_3_blabla_project/screens/test/test_button_screen.dart';
import 'package:week_3_blabla_project/widgets/inputs/bla_location_picker.dart';
import 'model/ride/locations.dart';
import 'model/ride_pref/ride_pref.dart';
import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}
//Location? initRidePref;
class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      //home: Scaffold(body: RidePrefScreen()),
      //home: AvailableRides()
      //home: TestButtonScreen()
      home: Scaffold(body: RidePrefForm())
      //home: Scaffold(body: BlaLocationPicker(locations: initRidePref)),
    );
  }
}

