// lib/features/city/presentation/pages/city_page.dart

import 'package:city_app/features/city/presentation/provider/city_provider.dart';
import 'package:city_app/features/city/presentation/widgets/city_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../widgets/city_list_widget.dart';

class CityPage extends ConsumerStatefulWidget {
  const CityPage({super.key});

  @override
  ConsumerState<CityPage> createState() => _CityPageState();
}

class _CityPageState extends ConsumerState<CityPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cityProvider.notifier).fetchCities('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cityProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Города'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                showSearch(
                    context: context,
                    delegate: CitySearchDelegate((state.maybeWhen(
                        loaded: (cities) => cities, orElse: () => []))));
              },
            ),
          ],
        ),
        body: state.maybeWhen(
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (cities) => CityListWidget(cities: cities),
          error: (message) => Center(child: Text(message)),
          orElse: () => const SizedBox(),
        ),
      ),
    );
  }
}
