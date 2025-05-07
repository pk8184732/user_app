

import 'package:flutter/material.dart';

class LocationSelectionScreen extends StatelessWidget {
  final List<String> _nearbyLocations = [
    "Maker, Bihar",
    "Jagdishpur, Bihar",
    "Bishunpura, Bihar",
    "Sonho, Bihar",
    "Bheldi, Bihar"
  ];

   LocationSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location",style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF096056),
      ),
      body: ListView.builder(
        itemCount: _nearbyLocations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_nearbyLocations[index]),
            trailing: const Icon(Icons.location_on, color: Colors.green),
            onTap: () {
              Navigator.pop(context, _nearbyLocations[index]);
            },
          );
        },
      ),
    );
  }
}
