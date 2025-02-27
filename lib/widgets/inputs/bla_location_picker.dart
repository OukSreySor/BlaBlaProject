import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';

class BlaLocationPicker extends StatefulWidget {
  final List<Location> locations;
  const BlaLocationPicker({super.key, required this.locations});

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  String searchQuery = "";
  TextEditingController searchController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    List<Location> filteredLocations = widget.locations
        .where((location) =>
            location.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: IconButton(
                    icon: Icon(Icons.arrow_back, color: BlaColors.iconNormal),
                    onPressed: () => Navigator.pop(context),
                  ),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: BlaColors.iconNormal),
                          onPressed: () {
                            setState(() {
                              searchQuery = "";
                              searchController.clear();
                            });
                          },
                        )
                      : null,
                  hintText: "Search location...",
                
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: filteredLocations.length,
                separatorBuilder: (context, index) => BlaDivider(),
                itemBuilder: (context, index) {
                  final location = filteredLocations[index];
                  return ListTile(
                    leading: Icon(Icons.history, color: BlaColors.primary),
                    title: Text(location.name),
                    subtitle: Text(location.country.name),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward, color: BlaColors.iconNormal),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    onTap: (){},
                  );
                }
              )
            ),
          ],
        ),
    );  
  }
}