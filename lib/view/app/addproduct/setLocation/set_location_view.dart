import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:second_hand/product/utilities/location/location_manager.dart';

class SetLocationView extends StatefulWidget {
  const SetLocationView({super.key});

  @override
  State<SetLocationView> createState() => _SetLocationViewState();
}

class _SetLocationViewState extends State<SetLocationView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Location',
          ),
        ),
        body: Column(
          children: [
            FutureBuilder(
              future: LocationManager.instance.getCurrentPositionInformations(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Text('Loading....');
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final placeMark = snapshot.data as Placemark;
                      return Card(
                        child: ListTile(
                          title: const Text('Location'),
                          subtitle: Row(
                            children: [
                              const Icon(
                                Icons.location_city,
                              ),
                              Text('${placeMark.country} ${placeMark.administrativeArea}'),
                            ],
                          ),
                          trailing: const Icon(
                            Icons.arrow_right,
                          ),
                        ),
                      );
                    }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
