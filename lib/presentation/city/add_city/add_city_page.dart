import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_weather/domain/models/manage_cities/add_city_model.dart';
import 'package:my_weather/presentation/city/add_city/providers/add_city_page_controller.dart';
import 'package:my_weather/ui/common_widgets/app_error_widget.dart';
import 'package:my_weather/ui/common_widgets/app_loading_widget.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';

class AddCityPage extends ConsumerStatefulWidget {
  const AddCityPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddCityPageState();
}

class _AddCityPageState extends ConsumerState<AddCityPage> {
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
    final result = ref.watch(addCityPageControllerProvider);

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
    final result = ref.watch(addCityPageControllerProvider);

    return result.when(
      data: (data) {
        if (data == null) {
          return Container();
        }

        if (data.isEmpty) {
          return Center(
            child: Text(
              '404 - Page not found!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
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
                  onTap: () => _onSelectedGeocoding(item),
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
      ref.read(addCityPageControllerProvider.notifier).fetchGeocoding(search);
    }
  }

  void _onSelectedGeocoding(AddCityModel addCity) {
    ref.read(addCityPageControllerProvider.notifier).selectedGeocoding(addCity);
    context.pop();
  }
}
