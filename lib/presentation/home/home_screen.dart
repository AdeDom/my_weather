import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/presentation/home/home_page.dart';
import 'package:my_weather/routing/app_router.dart';
import 'package:my_weather/ui/common_widgets/app_empty_widget.dart';
import 'package:my_weather/ui/common_widgets/app_error_widget.dart';
import 'package:my_weather/ui/common_widgets/app_loading_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _pageViewIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBarWidget(),
      body: _buildPageViewWidget(),
    );
  }

  AppBar _buildAppBarWidget() {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return AppBar(
      systemOverlayStyle:
          isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      backgroundColor: Colors.transparent,
      title: _buildTitleAppBarWidget(),
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

  Widget? _buildTitleAppBarWidget() {
    final result = ref.watch(getGeographicalCoordinatesAllProvider);

    return result.when(
      data: (data) {
        return Text(
          data.isEmpty ? 'My Weather' : data[_pageViewIndex].name,
          style: Theme.of(context).textTheme.headlineMedium,
        );
      },
      error: (error, _) => Text(
        'My Weather',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      loading: () => Text(
        'My Weather',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Widget _buildPageViewWidget() {
    final result = ref.watch(getGeographicalCoordinatesAllProvider);

    return result.when(
      data: (data) {
        if (data.isEmpty) {
          return const AppEmptyWidget();
        }

        return PageView(
          onPageChanged: _onPageViewChanged,
          children: data
              .map((element) => HomePage(geographicalCoordinates: element))
              .toList(),
        );
      },
      error: (error, _) => const AppErrorWidget(),
      loading: () => const AppLoadingWidget(),
    );
  }

  void _onPageViewChanged(int value) {
    setState(() {
      _pageViewIndex = value;
    });
  }

  void _onOpenCityScreen() {
    context.goNamed(AppRoute.cityLanding.name);
  }

  void _onOpenSettingsScreen() {
    context.goNamed(AppRoute.settings.name);
  }
}
