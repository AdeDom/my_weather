import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/generated/locale_keys.g.dart';
import 'package:my_weather/src/data/models/response/geographical_coordinates/geographical_coordinates_response.dart';
import 'package:my_weather/src/presentation/city/geographical_coordinates/providers/geographical_coordinates_page_controller.dart';
import 'package:my_weather/src/presentation/city/geographical_coordinates/widgets/geographical_coordinates_list_widget.dart';
import 'package:my_weather/src/ui/common_widgets/app_sizes.dart';

class GeographicalCoordinatesPage extends ConsumerStatefulWidget {
  const GeographicalCoordinatesPage({
    super.key,
    required this.onSelected,
  });

  final Function(GeographicalCoordinatesResponse) onSelected;

  @override
  ConsumerState createState() => _GeographicalCoordinatesPageState();
}

class _GeographicalCoordinatesPageState
    extends ConsumerState<GeographicalCoordinatesPage> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();

  String get search => _searchController.text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: context.pop,
          child: Text(LocaleKeys.common_cancel.tr()),
        ),
        leadingWidth: Sizes.p80,
        title: Text(LocaleKeys.geographical_coordinates_add_city.tr()),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildFormWidget(),
          GeographicalCoordinatesListWidget(onSelected: widget.onSelected),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildFormWidget() {
    final result = ref.watch(geographicalCoordinatesPageControllerProvider);

    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: _searchController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Sizes.p32),
              ),
            ),
            hintText: LocaleKeys.geographical_coordinates_search.tr(),
            enabled: !result.isLoading,
          ),
          textInputAction: TextInputAction.search,
          onEditingComplete: _searchEditingComplete,
          validator: (search) {
            return search?.isEmpty == true
                ? LocaleKeys.geographical_coordinates_please_enter_search.tr()
                : null;
          },
        ),
      ),
    );
  }

  void _searchEditingComplete() {
    if (_formKey.currentState?.validate() == true) {
      ref
          .read(geographicalCoordinatesPageControllerProvider.notifier)
          .fetchGeographicalCoordinates(search);
    }
  }
}
