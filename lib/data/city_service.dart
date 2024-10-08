import 'package:city_app/data/model/city_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CityService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://odigital.pro/locations/'),
  );

  Future<List<CityModel>> fetchCities({String? search}) async {
    try {
      final response = await _dio.get(
        queryParameters: search != null ? {'search': search} : null,
        'cities/',
      );
      return (response.data as List)
          .map((cityJson) => CityModel.fromJson(cityJson))
          .toList();
    } catch (e) {
      throw Exception('Failed to load cities: $e');
    }
  }

  Future<void> cacheCities(List<CityModel> cities) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cached_cities', jsonEncode(cities));
  }

  Future<List<CityModel>?> getCachedCities() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedData = prefs.getString('cached_cities');
    if (cachedData != null) {
      List<dynamic> jsonList = jsonDecode(cachedData);
      return jsonList.map((json) => CityModel.fromJson(json)).toList();
    }
    return null;
  }
}
