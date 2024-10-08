import 'package:city_app/data/city_service.dart';
import 'package:city_app/data/model/city_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final apiServiceProvider = Provider<CityService>((ref) {
  return CityService();
});

final citiesProvider =
    StateNotifierProvider<CitiesNotifier, List<CityModel>>((ref) {
  return CitiesNotifier(ref.read(apiServiceProvider));
});

class CitiesNotifier extends StateNotifier<List<CityModel>> {
  final CityService _apiService;
  CitiesNotifier(this._apiService) : super([]);

  Future<void> fetchCities(String? search) async {
    try {
      List<CityModel> cities = await _apiService.fetchCities(search: search);
      state = cities;
    } catch (e) {
      throw Exception('Failed to load cities');
    }
  }
}
