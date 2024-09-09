import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/presentation/home/home_page.dart';
import 'package:my_weather/presentation/home/providers/home_controller.dart';
import 'package:my_weather/routing/app_router.dart';
import 'package:my_weather/ui/common_widgets/app_empty_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: _buildTitleAppBarWidget(),
        actions: [
          IconButton(
            onPressed: () => context.goNamed(AppRoute.manageCities.name),
            icon: Icon(
              Icons.location_city,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          IconButton(
            onPressed: () => context.goNamed(AppRoute.settings.name),
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
      body: _buildPageViewWidget(),
    );
  }

  Widget _buildPageViewWidget() {
    final result = ref.watch(getGeocodingAllProvider);

    if (result.isEmpty) {
      return const AppEmptyWidget();
    }

    return PageView(
      onPageChanged: _onPageViewChanged,
      children: result.map((element) => HomePage(geocoding: element)).toList(),
    );
  }

  Widget _buildTitleAppBarWidget() {
    final result = ref.watch(getGeocodingAllProvider);
    final pageViewIndex = ref.watch(homePageViewIndexControllerProvider);

    if (result.isEmpty) {
      return Text(
        'My Weather',
        style: Theme.of(context).textTheme.headlineMedium,
      );
    }

    return Text(
      result[pageViewIndex].name,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  void _onPageViewChanged(int value) {
    ref
        .read(homePageViewIndexControllerProvider.notifier)
        .onPageViewChange(value);
  }
}
