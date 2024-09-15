import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/presentation/home/widgets/home_page_view_widget.dart';
import 'package:my_weather/presentation/home/widgets/home_title_app_bar_widget.dart';
import 'package:my_weather/router/enum/app_router_screen.dart';

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
      body: HomePageViewWidget(
        onPageViewChanged: _onPageViewChanged,
      ),
    );
  }

  AppBar _buildAppBarWidget() {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return AppBar(
      systemOverlayStyle:
          isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      backgroundColor: Colors.transparent,
      title: HomeTitleAppBarWidget(pageViewIndex: _pageViewIndex),
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
