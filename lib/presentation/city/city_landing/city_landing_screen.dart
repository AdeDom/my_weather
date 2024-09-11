import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/data/models/response/geographical_coordinates/geographical_coordinates_response.dart';
import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/presentation/city/city_landing/models/geographical_coordinates_model.dart';
import 'package:my_weather/presentation/city/city_landing/providers/city_landing_controller.dart';
import 'package:my_weather/presentation/city/city_landing/widgets/city_landing_action_widget.dart';
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
  List<GeographicalCoordinatesModel> _geographicalCoordinatesList = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    final list = await ref.read(getGeographicalCoordinatesAllProvider.future);
    final geographicalCoordinatesList = list.map((element) {
      return GeographicalCoordinatesModel.fromEntity(data: element);
    }).toList();
    setState(() {
      _geographicalCoordinatesList = geographicalCoordinatesList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: CityLandingListViewWidget(
        geographicalCoordinatesList: _geographicalCoordinatesList,
        isAddOrDelete: _isAddOrDelete,
        onItemChecked: _onItemChecked,
      ),
      floatingActionButton: CityLandingActionWidget(
        isAddOrDelete: _isAddOrDelete,
        onRemoveList: _onRemoveList,
        onShowBottomSheet: _onShowBottomSheet,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final isSelectAll =
        _geographicalCoordinatesList.every((element) => element.isDelete);
    if (_isAddOrDelete) {
      return AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: TextButton(
          onPressed: _onCancelAction,
          child: const Text('Cancel'),
        ),
        leadingWidth: Sizes.p80,
        title: CityLandingTitleAppBarWidget(
          geographicalCoordinatesList: _geographicalCoordinatesList,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _onCheckedAll,
            child: Text(isSelectAll ? 'Deselect all' : 'Select all'),
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

    ref
        .read(cityLandingControllerProvider.notifier)
        .selectedGeographicalCoordinates(data);

    final item = GeographicalCoordinatesModel.fromResponse(data: data);
    _geographicalCoordinatesList.add(item);
    setState(() {
      _geographicalCoordinatesList = _geographicalCoordinatesList;
    });
  }

  void _onRemoveList() {
    ref
        .read(cityLandingControllerProvider.notifier)
        .removeList(_geographicalCoordinatesList);

    final geographicalCoordinatesList = _geographicalCoordinatesList
        .where((element) => !element.isDelete)
        .toList();
    setState(() {
      _geographicalCoordinatesList = geographicalCoordinatesList;
      _isAddOrDelete = !_isAddOrDelete;
    });
  }

  void _onCancelAction() {
    final geographicalCoordinatesList = _geographicalCoordinatesList
        .map((element) => element.copyWith(isDelete: false))
        .toList();
    setState(() {
      _geographicalCoordinatesList = geographicalCoordinatesList;
      _isAddOrDelete = !_isAddOrDelete;
    });
  }

  void _onCheckedAll() {
    final isSelectAll =
        _geographicalCoordinatesList.every((element) => element.isDelete);
    final geographicalCoordinatesList = _geographicalCoordinatesList
        .map((element) => element.copyWith(isDelete: !isSelectAll))
        .toList();
    setState(() {
      _geographicalCoordinatesList = geographicalCoordinatesList;
    });
  }

  void _onItemChecked(GeographicalCoordinatesModel item) {
    final geographicalCoordinatesList =
        _geographicalCoordinatesList.map((element) {
      final isItem = element.id == item.id;
      final isDelete = isItem ? !element.isDelete : element.isDelete;
      return element.copyWith(isDelete: isDelete);
    }).toList();
    setState(() {
      _geographicalCoordinatesList = geographicalCoordinatesList;
    });
  }
}
