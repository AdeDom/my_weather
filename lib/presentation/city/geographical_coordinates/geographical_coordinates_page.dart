import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/data/models/response/geographical_coordinates/geographical_coordinates_response.dart';
import 'package:my_weather/presentation/city/geographical_coordinates/providers/geographical_coordinates_page_controller.dart';
import 'package:my_weather/presentation/city/geographical_coordinates/widgets/geographical_coordinates_list_widget.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';

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
          child: const Text('Cancel'),
        ),
        leadingWidth: Sizes.p80,
        title: const Text('Add city'),
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
            hintText: 'Search',
            enabled: !result.isLoading,
          ),
          textInputAction: TextInputAction.search,
          onEditingComplete: _searchEditingComplete,
          validator: (search) {
            return search?.isEmpty == true ? 'Please enter search' : null;
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
