import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/domain/models/manage_cities/manage_cities_model.dart';
import 'package:my_weather/utils/extensions/mapper_extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manage_cities_controller.g.dart';

@riverpod
class ManageCitiesGeocodingListController
    extends _$ManageCitiesGeocodingListController {
  @override
  List<ManageCitiesModel> build() {
    return ref.watch(getManageCitiesProvider);
  }

  void checkboxChange(ManageCitiesModel item) {
    state = state.map((element) {
      return element.copyWith(
        isRemove: element.name == item.name && element.state == item.state
            ? !element.isRemove
            : element.isRemove,
      );
    }).toList();
  }

  void checkboxAll(bool isRemove) {
    state = state.map((element) {
      return element.copyWith(isRemove: isRemove);
    }).toList();
  }

  void removeList() {
    for (var element in state) {
      if (element.isRemove) {
        final geocodingEntity = element.toGeocodingEntity();
        ref.read(removeGeocodingProvider(geocoding: geocodingEntity));
      }
    }
    ref.invalidate(getManageCitiesProvider);
    ref.invalidate(getGeocodingAllProvider);
  }
}

@riverpod
class ManageCitiesAddOrDeleteController
    extends _$ManageCitiesAddOrDeleteController {
  @override
  bool build() {
    return false;
  }

  void onChangeAction() {
    state = !state;
  }
}
