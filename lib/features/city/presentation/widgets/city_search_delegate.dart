import 'package:city_app/features/city/data/models/city_model.dart';
import 'package:city_app/features/city/presentation/widgets/city_list_widget.dart';
import 'package:flutter/material.dart';

class CitySearchDelegate extends SearchDelegate<String> {
  final List<CityModel> cities;

  CitySearchDelegate(this.cities);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, ''));
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = cities
        .where((city) => city.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return results.isEmpty
        ? const Center(child: Text('Ничего не найдено'))
        : CityListWidget(cities: results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = cities
        .where((city) => city.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return suggestions.isEmpty
        ? const Center(child: Text('Нет предложений'))
        : ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final city = suggestions[index];
              return ListTile(
                title: Text(city.name),
                onTap: () {
                  query = city.name;
                  showResults(context);
                },
              );
            },
          );
  }
}
