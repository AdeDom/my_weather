import 'package:my_weather/data/models/entity/geographical_coordinates/geographical_coordinates_entity.dart';
import 'package:my_weather/data/models/response/geographical_coordinates/geographical_coordinates_response.dart';
import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/presentation/city/city_landing/models/geographical_coordinates_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'city_landing_controller.g.dart';

@riverpod
class CityLandingController extends _$CityLandingController {
  @override
  void build() {}

  void selectedGeographicalCoordinates(GeographicalCoordinatesResponse data) {
    ref.read(addGeographicalCoordinatesProvider(geographicalCoordinates: data));
    ref.invalidate(getGeographicalCoordinatesAllProvider);
  }

  void removeList(
    List<GeographicalCoordinatesModel> geographicalCoordinatesList,
  ) {
    for (var element in geographicalCoordinatesList) {
      if (element.isDelete) {
        final entity = GeographicalCoordinatesEntity.fromModel(data: element);
        ref.read(removeGeographicalCoordinatesProvider(entity: entity));
      }
    }
    ref.invalidate(getGeographicalCoordinatesAllProvider);
  }
}
