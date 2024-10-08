import 'package:city_app/features/city/data/models/city_model.dart';
import 'package:dartz/dartz.dart';

abstract class CityRepository {
  Future<Either<String, List<CityModel>>> fetchCities(String? searchQuery);
}
