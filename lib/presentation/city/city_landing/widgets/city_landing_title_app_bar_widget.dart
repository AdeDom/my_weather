import 'package:flutter/material.dart';
import 'package:my_weather/presentation/city/city_landing/models/geographical_coordinates_model.dart';

class CityLandingTitleAppBarWidget extends StatelessWidget {
  const CityLandingTitleAppBarWidget({
    super.key,
    required this.geographicalCoordinatesList,
  });

  final List<GeographicalCoordinatesModel> geographicalCoordinatesList;

  @override
  Widget build(BuildContext context) {
    final list = geographicalCoordinatesList;
    final isSelectAll = list.every((element) => element.isDelete);
    final isDeselectAll = list.any((element) => element.isDelete);
    final countSelected = list.where((element) => element.isDelete).length;
    if (isSelectAll) {
      return const Text('All selected');
    } else if (isDeselectAll) {
      return Text('$countSelected Selected');
    } else {
      return const Text('Select items');
    }
  }
}
