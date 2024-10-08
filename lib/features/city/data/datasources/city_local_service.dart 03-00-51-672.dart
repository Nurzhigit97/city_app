import 'package:city_app/features/city/data/models/city_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CityLocalService {
  static const String _cacheKey = 'cached_cities';

  /// Сохранение городов в кэш
  static Future<void> setCitiesToCache(List<CityModel> cities) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString =
        jsonEncode(cities.map((city) => city.toJson()).toList());
    await prefs.setString(_cacheKey, jsonString);
  }

  /// Получение городов из кэша
  static Future<List<CityModel>?> getCachedCities() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_cacheKey);

    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      List<CityModel> cities =
          jsonList.map((json) => CityModel.fromJson(json)).toList();
      return cities;
    }

    return null;
  }
}
