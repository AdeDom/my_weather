import 'package:flutter/material.dart';
import 'package:my_weather/presentation/city/city_landing/models/geographical_coordinates_model.dart';
import 'package:my_weather/ui/common_widgets/app_empty_widget.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';

class CityLandingListViewWidget extends StatelessWidget {
  const CityLandingListViewWidget({
    super.key,
    required this.geographicalCoordinatesList,
    required this.isAddOrDelete,
    required this.onItemChecked,
  });

  final List<GeographicalCoordinatesModel> geographicalCoordinatesList;
  final bool isAddOrDelete;
  final Function(GeographicalCoordinatesModel) onItemChecked;

  @override
  Widget build(BuildContext context) {
    if (geographicalCoordinatesList.isEmpty) {
      return const AppEmptyWidget();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p16,
        vertical: Sizes.p16,
      ),
      itemCount: geographicalCoordinatesList.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildCityCard(context, geographicalCoordinatesList[index]);
      },
    );
  }

  Widget _buildCityCard(
    BuildContext context,
    GeographicalCoordinatesModel item,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.p16),
      child: Card(
        color: Theme.of(context).colorScheme.onPrimary,
        child: ListTile(
          title: Text(
            item.name,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          subtitle: Text(
            item.state,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          trailing: isAddOrDelete
              ? Checkbox(
                  value: item.isDelete,
                  onChanged: (value) => onItemChecked(item),
                )
              : Container(width: Sizes.p2),
        ),
      ),
    );
  }
}
