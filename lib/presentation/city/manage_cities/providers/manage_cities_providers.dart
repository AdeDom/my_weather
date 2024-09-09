import 'package:my_weather/presentation/city/manage_cities/providers/manage_cities_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manage_cities_providers.g.dart';

@riverpod
bool isGeocodingListSelectAll(IsGeocodingListSelectAllRef ref) {
  final geocodingList = ref.watch(manageCitiesGeocodingListControllerProvider);
  return geocodingList.every((element) => element.isRemove);
}

@riverpod
bool isGeocodingListDeselectAll(IsGeocodingListDeselectAllRef ref) {
  final geocodingList = ref.watch(manageCitiesGeocodingListControllerProvider);
  return geocodingList.any((element) => element.isRemove);
}

@riverpod
int getGeocodingListCountSelected(GetGeocodingListCountSelectedRef ref) {
  final geocodingList = ref.watch(manageCitiesGeocodingListControllerProvider);
  return geocodingList.where((element) => element.isRemove).length;
}
