import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/data/models/entity/geographical_coordinates/geographical_coordinates_entity.dart';
import 'package:my_weather/src/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/src/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/src/presentation/home/home_page.dart';
import 'package:my_weather/src/router/enum/app_router_screen.dart';
import 'package:my_weather/src/ui/common_widgets/app_empty_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _pageViewIndex = 0;

  @override
  Widget build(BuildContext context) {
    final geographicalCoordinates =
        ref.watch(getGeographicalCoordinatesAllProvider).value;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBarWidget(geographicalCoordinates),
      body: _buildPageViewWidget(geographicalCoordinates),
    );
  }

  AppBar _buildAppBarWidget(List<GeographicalCoordinatesEntity>? data) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    final title = (data == null || data.isEmpty)
        ? LocaleKeys.common_app_name.tr()
        : data[_pageViewIndex].name;
    return AppBar(
      systemOverlayStyle:
          isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      actions: [
        IconButton(
          onPressed: _onOpenCityScreen,
          icon: Icon(
            Icons.location_city,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        IconButton(
          onPressed: _onOpenSettingsScreen,
          icon: Icon(
            Icons.settings,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildPageViewWidget(List<GeographicalCoordinatesEntity>? data) {
    if (data == null || data.isEmpty) {
      return const AppEmptyWidget();
    }

    return PageView(
      onPageChanged: _onPageViewChanged,
      children: data
          .map((element) => HomePage(geographicalCoordinates: element))
          .toList(),
    );
  }

  void _onPageViewChanged(int value) {
    setState(() {
      _pageViewIndex = value;
    });
  }

  void _onOpenCityScreen() {
    context.goNamed(AppRouteScreen.cityLanding.name);
  }

  void _onOpenSettingsScreen() {
    context.goNamed(AppRouteScreen.settings.name);
  }
}
