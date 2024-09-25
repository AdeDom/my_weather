import 'package:my_weather/src/data/models/response/geographical_coordinates/geographical_coordinates_response.dart';
import 'package:my_weather/src/data/repositories/open_weather/open_weather_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'geographical_coordinates_page_controller.g.dart';

@riverpod
class GeographicalCoordinatesPageController
    extends _$GeographicalCoordinatesPageController {
  @override
  FutureOr<List<GeographicalCoordinatesResponse>?> build() {
    return null;
  }

  Future<void> fetchGeographicalCoordinates(String search) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () {
        return ref.read(
          fetchGeographicalCoordinatesProvider(search: search).future,
        );
      },
    );
  }
}
