import 'package:flutter/material.dart';

import '../../dummy_data/dummy_data.dart';
import '../../model/ride/ride.dart';

class AvailableRides extends StatelessWidget {
  const AvailableRides({super.key});

  @override
  Widget build(BuildContext context) {
    // Filter fakeRides for today
    List<Ride> todayRides = fakeRides.where((ride) {
      // Check if the ride is for today (departure date is today)
      return ride.departureDate.year == DateTime.now().year &&
             ride.departureDate.month == DateTime.now().month &&
             ride.departureDate.day == DateTime.now().day;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Available Rides Today'),
      ),
      body: todayRides.isEmpty
          ? Center(child: Text('No rides available today'))
          : ListView.builder(
              itemCount: todayRides.length,
              itemBuilder: (context, index) {
                Ride ride = todayRides[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text('Departure from: ${ride.departureLocation.name} \nTo: ${ride.arrivalLocation.name}'),
                    subtitle: Text('Driver: ${ride.driver.firstName} ${ride.driver.lastName}'),
                    trailing: Text('${ride.pricePerSeat}€ per seat'),
                  ),
                );
              },
            ),
    );
  }
}