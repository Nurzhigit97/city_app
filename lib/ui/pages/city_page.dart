import 'package:city_app/ui/provider/city_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CityPage extends HookConsumerWidget {
  const CityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final cities = ref.watch(citiesProvider);

    useEffect(() {
      ref.read(citiesProvider.notifier).fetchCities(null);
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('City Search'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Cities',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    ref
                        .read(citiesProvider.notifier)
                        .fetchCities(searchController.text);
                  },
                ),
              ),
              onSubmitted: (value) {
                ref.read(citiesProvider.notifier).fetchCities(value);
              },
            ),
          ),
        ),
      ),
      body: cities.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: cities.length,
              itemBuilder: (context, index) {
                final city = cities[index];
                return ListTile(
                  title: Text(city.name),
                );
              },
            ),
    );
  }
}
