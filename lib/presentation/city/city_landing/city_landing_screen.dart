import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/data/models/response/geographical_coordinates/geographical_coordinates_response.dart';
import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/presentation/city/city_landing/widgets/city_landing_action_widget.dart';
import 'package:my_weather/presentation/city/city_landing/widgets/city_landing_checked_all_widget.dart';
import 'package:my_weather/presentation/city/city_landing/widgets/city_landing_list_view_widget.dart';
import 'package:my_weather/presentation/city/city_landing/widgets/city_landing_title_app_bar_widget.dart';
import 'package:my_weather/presentation/city/geographical_coordinates/geographical_coordinates_page.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';

class CityLandingScreen extends ConsumerStatefulWidget {
  const CityLandingScreen({super.key});

  @override
  ConsumerState createState() => _CityLandingScreenState();
}

class _CityLandingScreenState extends ConsumerState<CityLandingScreen> {
  bool _isAddOrDelete = false;
  bool? _isCheckedAll;
  List<String> _selectIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: CityLandingListViewWidget(
        isAddOrDelete: _isAddOrDelete,
        isCheckedAll: _isCheckedAll,
        onSelectItem: _onSelectItem,
      ),
      floatingActionButton: CityLandingActionWidget(
        isAddOrDelete: _isAddOrDelete,
        onRemoveList: _onRemoveList,
        onShowBottomSheet: _onShowBottomSheet,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    if (_isAddOrDelete) {
      return AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: TextButton(
          onPressed: _onCancelAction,
          child: const Text('Cancel'),
        ),
        leadingWidth: Sizes.p80,
        title: CityLandingTitleAppBarWidget(selectIds: _selectIds),
        centerTitle: true,
        actions: [
          CityLandingCheckedAllWidget(
            selectIds: _selectIds,
            onCheckedAll: _onCheckedAll,
          ),
        ],
      );
    } else {
      return AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Manage cities'),
        actions: [
          IconButton(
            onPressed: _onChangeAction,
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      );
    }
  }

  void _onChangeAction() {
    setState(() {
      _isAddOrDelete = !_isAddOrDelete;
      _isCheckedAll = null;
    });
  }

  void _onShowBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) => GeographicalCoordinatesPage(
        onSelected: _onSelectedGeographicalCoordinates,
      ),
    );
  }

  void _onSelectedGeographicalCoordinates(
    GeographicalCoordinatesResponse data,
  ) {
    context.pop();

    ref.read(addGeographicalCoordinatesProvider(geographicalCoordinates: data));
    ref.invalidate(getGeographicalCoordinatesAllProvider);
  }

  void _onRemoveList() {
    ref.read(deleteByIdsProvider(selectIds: _selectIds));
    ref.invalidate(getGeographicalCoordinatesAllProvider);

    setState(() {
      _isAddOrDelete = !_isAddOrDelete;
      _isCheckedAll = null;
      _selectIds = [];
    });
  }

  void _onCancelAction() {
    setState(() {
      _isAddOrDelete = !_isAddOrDelete;
      _isCheckedAll = null;
      _selectIds = [];
    });
  }

  void _onCheckedAll() {
    setState(() {
      _isCheckedAll = !(_isCheckedAll ?? false);
    });
  }

  void _onSelectItem(List<String> selectIds) {
    setState(() {
      _selectIds = selectIds;
      _isCheckedAll = null;
    });
  }
}
