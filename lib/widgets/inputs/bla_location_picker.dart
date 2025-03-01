import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

import '../../service/locations_service.dart';

class BlaLocationPicker extends StatefulWidget {
  final Location? locations;
  const BlaLocationPicker({
    super.key,
    required this.locations,
  });

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {

  List<Location> filteredLocations = [];
  
  @override
  void initState() {
    super.initState();
    filteredLocations = widget.locations != null
      ? getLocations(widget.locations!.name)
      : [];
    //filteredLocations = getLocations(widget.locations!.name);
  }
  
  void onBackSelected() {
    Navigator.of(context).pop();
  }
// _openlocation
  void onLocationSelected(Location location) {
    Navigator.of(context).pop(location);
  }

  void onSearchChanged(String searchText) {
    List<Location> selectedLocation = [];

    if(searchText.length > 1) {
      selectedLocation = getLocations(searchText);
    }
    setState(() {
      filteredLocations = selectedLocation;
    });
  }
  
  List<Location> getLocations(String text) {
    return LocationsService.availableLocations
        .where((location) =>
            location.name.toUpperCase().contains(text.toUpperCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
            children: [
              BlaSearchBar(
                onBackPressed: onBackSelected,
                onSearchChanged: onSearchChanged,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredLocations.length,
                  itemBuilder: (ctx, index) => LocationTile(
                    location: filteredLocations[index],
                    onSelected: onLocationSelected,
                  ),
                ),
              ),
            ]
                      
            ),
    );
  }
}

class BlaSearchBar extends StatefulWidget {
  const BlaSearchBar({
    super.key,
    required this.onSearchChanged, 
    required this.onBackPressed
  });

  final Function(String text) onSearchChanged;
  final VoidCallback onBackPressed;

  @override
  State<BlaSearchBar> createState() => _BlaSearchBarState();
}

class _BlaSearchBarState extends State<BlaSearchBar> {

  final TextEditingController _textController = TextEditingController();
    @override
    void dispose() {
      _textController.dispose();
      super.dispose();
    }
  
  void onChanged(String newText) {
    // 1 - Notity the listener
    widget.onSearchChanged(newText);
    // 2 - Update UI to show/hide clear button
    setState(() {});
  }

  void clearSearch() {
    _textController.clear();
    onChanged("");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              onPressed: widget.onBackPressed,
              icon: Icon(
                Icons.arrow_back_ios,
                color: BlaColors.iconLight,
                size: 16,
              ),
            ),
          ),

          Expanded(
            child: TextField( 
              onChanged: onChanged,
              controller: _textController,
              style: TextStyle(color: BlaColors.textLight),
              decoration: InputDecoration(
                hintText: "Any city, street...",
                border: InputBorder.none,
              ),
            ),
          ),
          if (_textController.text.isNotEmpty) 
            IconButton(
              icon: Icon(Icons.close, color: BlaColors.iconLight, size: 16,),
              onPressed: clearSearch,
            ),
        ],
      ),
    );
  }
}

class LocationTile extends StatelessWidget {
  final Location location;
  final Function(Location location) onSelected;

  const LocationTile({super.key, required this.location, required this.onSelected});

  String get title => location.name;

  String get subTitle => location.country.name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onSelected(location),
      title: Text(
        title,
        style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal)
      ),
      subtitle: Text(
        subTitle,
        style: BlaTextStyles.label.copyWith(color: BlaColors.textLight)
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: BlaColors.iconLight,
        size: 16,
      ),
    );
  }
}