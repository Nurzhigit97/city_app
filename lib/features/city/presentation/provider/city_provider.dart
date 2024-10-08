// lib/features/city/presentation/provider/city_provider.dart

import 'package:city_app/features/city/domain/usecases/get_cities.dart';
import 'package:city_app/features/city/presentation/provider/city_state.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cityProvider = StateNotifierProvider<CityNotifier, CityState>((ref) {
  final getCities = GetIt.instance<GetCities>();
  return CityNotifier(getCities);
});

class CityNotifier extends StateNotifier<CityState> {
  final GetCities getCities;

  CityNotifier(this.getCities) : super(const CityState.initial());

  Future<void> fetchCities(String searchQuery) async {
    state = const CityState.loading();
    final result = await getCities(searchQuery);
    result.fold(
      (error) => state = CityState.error(error.toString()),
      (cities) => state = CityState.loaded(cities),
    );
  }
}
