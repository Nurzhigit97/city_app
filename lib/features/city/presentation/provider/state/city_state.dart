// lib/features/city/presentation/state/city_state.dart

import 'package:city_app/features/city/data/models/city_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_state.freezed.dart';

@freezed
class CityState with _$CityState {
  const factory CityState.initial() = _Initial;
  const factory CityState.loading() = _Loading;
  const factory CityState.loaded(List<CityModel> cities) = _Loaded;
  const factory CityState.error(String message) = _Error;
}
