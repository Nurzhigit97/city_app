// lib/features/city/data/datasources/remote_data_source.dart

import 'package:city_app/features/city/data/datasources/loca_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../models/city_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class RemoteDataSource {
  final Dio dio;
  final LocalDataSource localDataSource;

  RemoteDataSource(this.dio, this.localDataSource);

  Future<bool> _isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi);
  }

  Future<Either<String, List<CityModel>>> fetchCities(
      String? searchQuery) async {
    final cachedCities = await localDataSource.getCachedCities();
    final isConnected = await _isConnected();

    if (!isConnected) {
      if (cachedCities != null) {
        return Right(cachedCities);
      }
      return const Left(
          'Отсутствует интернет-соединение и нет кэшированных данных.');
    }

    try {
      final response = await dio.get('cities/', queryParameters: {
        if (searchQuery != null && searchQuery.isNotEmpty)
          'search': searchQuery,
      });
      final List<CityModel> cities = (response.data as List)
          .map((city) => CityModel.fromJson(city))
          .toList();

      // Cache the fetched cities
      localDataSource.setCitiesToCache(cities);
      return Right(cities);
    } catch (e) {
      // Handle error and attempt to return cached cities if available
      if (cachedCities != null) {
        return Right(cachedCities);
      }
      return const Left('Ошибка при загрузке данных');
    }
  }
}
