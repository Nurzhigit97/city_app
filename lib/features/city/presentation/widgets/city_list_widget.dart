import 'package:city_app/features/city/data/models/city_model.dart';
import 'package:flutter/material.dart';

class CityListWidget extends StatelessWidget {
  final List<CityModel> cities;

  const CityListWidget({super.key, required this.cities});

  @override
  Widget build(BuildContext context) {
    return cities.isEmpty
        ? const Center(
            child: Text('Нету городов'),
          )
        : ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final city = cities[index];
              return ListTile(
                title: Text(city.name),
              );
            },
          );
  }
}
