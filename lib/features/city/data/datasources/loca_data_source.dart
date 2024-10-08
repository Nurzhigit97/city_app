// lib/features/city/data/datasources/local_data_source.dart

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/city_model.dart';

class LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSource(this.sharedPreferences);
  static const String _cacheKey = 'cached_cities';

  Future<void> setCitiesToCache(List<CityModel> cities) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString =
        jsonEncode(cities.map((city) => city.toJson()).toList());
    await prefs.setString(_cacheKey, jsonString);
  }

  Future<List<CityModel>?> getCachedCities() async {
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
