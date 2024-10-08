import 'package:city_app/features/city/data/models/city_model.dart';
import 'package:city_app/features/city/domain/repositories/city_repo.dart';
import 'package:dartz/dartz.dart';
import '../datasources/remote_data_source.dart';

class CityRepositoryImpl implements CityRepository {
  final RemoteDataSource remoteDataSource;

  CityRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, List<CityModel>>> fetchCities(
          String? searchQuery) async =>
      remoteDataSource.fetchCities(searchQuery);
}
