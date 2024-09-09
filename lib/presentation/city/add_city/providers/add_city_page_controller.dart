import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/domain/models/manage_cities/add_city_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_city_page_controller.g.dart';

@riverpod
class AddCityPageController extends _$AddCityPageController {
  @override
  FutureOr<List<AddCityModel>?> build() {
    return null;
  }

  Future<void> fetchGeocoding(String search) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.watch(fetchGeocodingProvider(search: search).future),
    );
  }

  void selectedGeocoding(AddCityModel addCity) {
    ref.read(addGeocodingProvider(addCity: addCity));
    ref.invalidate(getManageCitiesProvider);
    ref.invalidate(getGeocodingAllProvider);
  }
}
