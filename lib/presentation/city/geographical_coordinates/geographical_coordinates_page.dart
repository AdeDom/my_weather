import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/data/models/response/geographical_coordinates/geographical_coordinates_response.dart';
import 'package:my_weather/presentation/city/geographical_coordinates/providers/geographical_coordinates_page_controller.dart';
import 'package:my_weather/ui/common_widgets/app_empty_widget.dart';
import 'package:my_weather/ui/common_widgets/app_error_widget.dart';
import 'package:my_weather/ui/common_widgets/app_loading_widget.dart';
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
          _buildCityListWidget(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Padding _buildFormWidget() {
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

  Widget _buildCityListWidget() {
    final result = ref.watch(geographicalCoordinatesPageControllerProvider);

    return result.when(
      data: (data) {
        if (data == null) {
          return Container();
        }

        if (data.isEmpty) {
          return const Center(
            child: AppEmptyWidget(),
          );
        }

        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.p16,
              vertical: Sizes.p8,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final item = data[index];
              return SizedBox(
                height: Sizes.p64,
                child: GestureDetector(
                  onTap: () => widget.onSelected(item),
                  child: Text(
                    '${item.name}, ${item.state}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              );
            },
          ),
        );
      },
      error: (error, _) => AppErrorWidget(message: error.toString()),
      loading: () => const AppLoadingWidget(),
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
