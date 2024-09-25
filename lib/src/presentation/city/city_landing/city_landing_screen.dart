import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/data/models/entity/geographical_coordinates/geographical_coordinates_entity.dart';
import 'package:my_weather/src/data/models/response/geographical_coordinates/geographical_coordinates_response.dart';
import 'package:my_weather/src/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/src/presentation/city/city_landing/widgets/city_landing_action_widget.dart';
import 'package:my_weather/src/presentation/city/city_landing/widgets/city_landing_list_view_widget.dart';
import 'package:my_weather/src/presentation/city/city_landing/widgets/city_landing_title_app_bar_widget.dart';
import 'package:my_weather/src/presentation/city/geographical_coordinates/geographical_coordinates_page.dart';
import 'package:my_weather/src/ui/common_widgets/app_sizes.dart';

class CityLandingScreen extends ConsumerStatefulWidget {
  const CityLandingScreen({super.key});

  @override
  ConsumerState createState() => _CityLandingScreenState();
}

class _CityLandingScreenState extends ConsumerState<CityLandingScreen> {
  bool _isAddOrDelete = false;
  bool _isCheckedAll = false;
  List<String> _selectIds = [];

  @override
  Widget build(BuildContext context) {
    final geographicalCoordinates =
        ref.watch(getGeographicalCoordinatesAllProvider).value;

    return Scaffold(
      appBar: _buildAppBar(geographicalCoordinates),
      body: CityLandingListViewWidget(
        geographicalCoordinates: geographicalCoordinates,
        selectIds: _selectIds,
        isAddOrDelete: _isAddOrDelete,
        onSelectItem: (id) => _onSelectItem(geographicalCoordinates, id),
      ),
      floatingActionButton: CityLandingActionWidget(
        isAddOrDelete: _isAddOrDelete,
        onRemoveList: _onRemoveList,
        onShowBottomSheet: _onShowBottomSheet,
      ),
    );
  }

  AppBar _buildAppBar(List<GeographicalCoordinatesEntity>? data) {
    if (_isAddOrDelete) {
      return AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: TextButton(
          onPressed: _onCancelAction,
          child: Text(LocaleKeys.common_cancel.tr()),
        ),
        leadingWidth: Sizes.p80,
        title: CityLandingTitleAppBarWidget(
          isSelectAll: _selectIds.length == data?.length,
          selectIds: _selectIds,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => _onCheckedAll(data),
            child: Text(
              _selectIds.length == data?.length
                  ? LocaleKeys.city_landing_deselect_all.tr()
                  : LocaleKeys.city_landing_select_all.tr(),
            ),
          ),
        ],
      );
    } else {
      return AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(LocaleKeys.city_landing_manage_cities.tr()),
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
      _isCheckedAll = false;
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

    final openWeatherRepository = ref.read(openWeatherRepositoryProvider);
    final entity = GeographicalCoordinatesEntity.fromResponse(data: data);
    openWeatherRepository.addGeographicalCoordinates(entity);

    ref.invalidate(getGeographicalCoordinatesAllProvider);
  }

  void _onRemoveList() {
    final openWeatherRepository = ref.read(openWeatherRepositoryProvider);
    openWeatherRepository.deleteByIds(_selectIds);

    ref.invalidate(getGeographicalCoordinatesAllProvider);

    setState(() {
      _isAddOrDelete = !_isAddOrDelete;
      _isCheckedAll = false;
      _selectIds = [];
    });
  }

  void _onCancelAction() {
    setState(() {
      _isAddOrDelete = !_isAddOrDelete;
      _isCheckedAll = false;
      _selectIds = [];
    });
  }

  void _onCheckedAll(List<GeographicalCoordinatesEntity>? data) {
    if (_isCheckedAll) {
      _selectIds.clear();
    } else {
      data?.map((e) => e.id).forEach(_selectIds.add);
    }

    setState(() {
      _selectIds = _selectIds;
      _isCheckedAll = !_isCheckedAll;
    });
  }

  void _onSelectItem(List<GeographicalCoordinatesEntity>? data, String id) {
    final isSelected = _selectIds.contains(id);
    if (isSelected) {
      _selectIds.remove(id);
    } else {
      _selectIds.add(id);
    }

    setState(() {
      _selectIds = _selectIds;
      _isCheckedAll = data?.length == _selectIds.length;
    });
  }
}
