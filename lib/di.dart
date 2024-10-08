import 'package:city_app/features/city/data/datasources/loca_data_source.dart';
import 'package:city_app/features/city/data/datasources/remote_data_source.dart';
import 'package:city_app/features/city/data/repositories/city_repo_impl.dart';
import 'package:city_app/features/city/domain/repositories/city_repo.dart';
import 'package:city_app/features/city/domain/usecases/get_cities.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> di() async {
  // Регистрация Dio
  getIt.registerLazySingleton<Dio>(
      () => Dio(BaseOptions(baseUrl: 'https://odigital.pro/locations/')));

  // Регистрация SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  // Регистрация LocalDataSource
  getIt.registerLazySingleton<LocalDataSource>(
      () => LocalDataSource(getIt<SharedPreferences>()));

  // Регистрация RemoteDataSource
  getIt.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSource(getIt<Dio>(), getIt<LocalDataSource>()));

  // Регистрация CityRepository
  getIt.registerLazySingleton<CityRepository>(
      () => CityRepositoryImpl(getIt<RemoteDataSource>()));

  // Пример регистрации
  getIt.registerFactory<GetCities>(() => GetCities(getIt<CityRepository>()));
}
