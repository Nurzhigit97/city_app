import 'package:city_app/features/city/domain/repositories/city_repo.dart';
import 'package:dartz/dartz.dart';
import '../../data/models/city_model.dart';

class GetCities {
  final CityRepository repository;

  GetCities(this.repository);

  Future<Either<String, List<CityModel>>> call(String? searchQuery) {
    return repository.fetchCities(searchQuery);
  }
}
