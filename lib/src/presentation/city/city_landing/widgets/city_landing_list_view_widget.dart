import 'package:flutter/material.dart';
import 'package:my_weather/src/data/models/entity/geographical_coordinates/geographical_coordinates_entity.dart';
import 'package:my_weather/src/ui/common_widgets/app_empty_widget.dart';
import 'package:my_weather/src/ui/common_widgets/app_sizes.dart';

class CityLandingListViewWidget extends StatelessWidget {
  const CityLandingListViewWidget({
    super.key,
    required this.geographicalCoordinates,
    required this.selectIds,
    required this.isAddOrDelete,
    required this.onSelectItem,
  });

  final List<GeographicalCoordinatesEntity>? geographicalCoordinates;
  final List<String> selectIds;
  final bool isAddOrDelete;
  final Function(String) onSelectItem;

  @override
  Widget build(BuildContext context) {
    final data = geographicalCoordinates;
    if (data == null || data.isEmpty) {
      return const AppEmptyWidget();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p16,
        vertical: Sizes.p16,
      ),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildCityCard(context, data[index]);
      },
    );
  }

  Widget _buildCityCard(
    BuildContext context,
    GeographicalCoordinatesEntity item,
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
                  value: selectIds.contains(item.id),
                  onChanged: (value) => onSelectItem(item.id),
                )
              : Container(width: Sizes.p2),
        ),
      ),
    );
  }
}
