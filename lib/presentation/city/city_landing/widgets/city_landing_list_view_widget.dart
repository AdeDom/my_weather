import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/data/models/entity/geographical_coordinates/geographical_coordinates_entity.dart';
import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/ui/common_widgets/app_empty_widget.dart';
import 'package:my_weather/ui/common_widgets/app_loading_widget.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';

class CityLandingListViewWidget extends ConsumerStatefulWidget {
  const CityLandingListViewWidget({
    super.key,
    required this.isAddOrDelete,
    required this.isCheckedAll,
    required this.onSelectItem,
  });

  final bool isAddOrDelete;
  final bool? isCheckedAll;
  final Function(List<String>) onSelectItem;

  @override
  ConsumerState createState() => _CityLandingListViewWidgetState();
}

class _CityLandingListViewWidgetState
    extends ConsumerState<CityLandingListViewWidget> {
  List<String> _selectIds = [];

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(getGeographicalCoordinatesAllProvider);

    return result.when(
      data: (data) {
        if (data.isEmpty) {
          return const AppEmptyWidget();
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.p16,
            vertical: Sizes.p16,
          ),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildCityCard(data[index]);
          },
        );
      },
      error: (error, _) => ErrorWidget(error.toString()),
      loading: () => const AppLoadingWidget(),
    );
  }

  Widget _buildCityCard(GeographicalCoordinatesEntity item) {
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
          trailing: widget.isAddOrDelete
              ? Checkbox(
                  value: widget.isCheckedAll != null
                      ? widget.isCheckedAll!
                      : _selectIds.contains(item.id),
                  onChanged: (value) => _onSelectItem(item.id),
                )
              : Container(width: Sizes.p2),
        ),
      ),
    );
  }

  _onSelectItem(String id) {
    final isSelected = _selectIds.contains(id);
    if (isSelected) {
      _selectIds.remove(id);
    } else {
      _selectIds.add(id);
    }
    setState(() {
      _selectIds = _selectIds;
    });
    widget.onSelectItem(_selectIds);
  }

  @override
  void didUpdateWidget(covariant CityLandingListViewWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final selectIds = widget.isAddOrDelete ? _selectIds : <String>[];
    _selectIds = selectIds;
  }
}
