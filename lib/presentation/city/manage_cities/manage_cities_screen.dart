import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/domain/models/manage_cities/manage_cities_model.dart';
import 'package:my_weather/presentation/city/add_city/add_city_page.dart';
import 'package:my_weather/presentation/city/manage_cities/providers/manage_cities_controller.dart';
import 'package:my_weather/presentation/city/manage_cities/providers/manage_cities_providers.dart';
import 'package:my_weather/ui/common_widgets/app_empty_widget.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';

class ManageCitiesScreen extends ConsumerStatefulWidget {
  const ManageCitiesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ManageCitiesScreenState();
}

class _ManageCitiesScreenState extends ConsumerState<ManageCitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildListViewWidget(),
      floatingActionButton: _buildActionWidget(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final isSelectAll = ref.watch(isGeocodingListSelectAllProvider);
    final isAddOrDelete = ref.watch(manageCitiesAddOrDeleteControllerProvider);
    if (isAddOrDelete) {
      return AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: TextButton(
          onPressed: _onCancelAction,
          child: const Text('Cancel'),
        ),
        leadingWidth: Sizes.p80,
        title: _buildTitleAppBarWidget(),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => _onCheckedAll(isSelectAll),
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

  Widget _buildListViewWidget() {
    final result = ref.watch(manageCitiesGeocodingListControllerProvider);

    if (result.isEmpty) {
      return const AppEmptyWidget();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p16,
        vertical: Sizes.p16,
      ),
      itemCount: result.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildCityCard(result[index]);
      },
    );
  }

  Widget _buildActionWidget() {
    final width = MediaQuery.sizeOf(context).width;
    final isAddOrDelete = ref.watch(manageCitiesAddOrDeleteControllerProvider);
    if (isAddOrDelete) {
      return InkWell(
        onTap: _onRemoveList,
        child: Container(
          height: Sizes.p64,
          width: width - Sizes.p32,
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.delete),
              Text(
                'Delete',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      );
    } else {
      return FloatingActionButton(
        onPressed: _showBottomSheet,
        child: const Icon(Icons.add),
      );
    }
  }

  Widget _buildCityCard(ManageCitiesModel item) {
    final isAddOrDelete = ref.watch(manageCitiesAddOrDeleteControllerProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.p16),
      child: Card(
        color: Theme.of(context).colorScheme.onPrimary,
        child: ListTile(
          title: Text(
            item.name,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          subtitle: Text(
            item.state,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          trailing: isAddOrDelete
              ? Checkbox(
                  value: item.isRemove,
                  onChanged: (value) => _onItemChecked(item),
                )
              : Container(width: Sizes.p2),
        ),
      ),
    );
  }

  Widget _buildTitleAppBarWidget() {
    final isSelectAll = ref.watch(isGeocodingListSelectAllProvider);
    final isDeselectAll = ref.watch(isGeocodingListDeselectAllProvider);
    final countSelected = ref.watch(getGeocodingListCountSelectedProvider);
    if (isSelectAll) {
      return const Text('All selected');
    } else if (isDeselectAll) {
      return Text('$countSelected Selected');
    } else {
      return const Text('Select items');
    }
  }

  void _onChangeAction() {
    ref
        .read(manageCitiesAddOrDeleteControllerProvider.notifier)
        .onChangeAction();
  }

  void _showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) => const AddCityPage(),
    );
  }

  void _onRemoveList() {
    ref
        .read(manageCitiesAddOrDeleteControllerProvider.notifier)
        .onChangeAction();
    ref.read(manageCitiesGeocodingListControllerProvider.notifier).removeList();
  }

  void _onCancelAction() {
    ref
        .read(manageCitiesAddOrDeleteControllerProvider.notifier)
        .onChangeAction();
    ref
        .read(manageCitiesGeocodingListControllerProvider.notifier)
        .checkboxAll(false);
  }

  void _onCheckedAll(bool isSelectAll) {
    ref
        .read(manageCitiesGeocodingListControllerProvider.notifier)
        .checkboxAll(!isSelectAll);
  }

  void _onItemChecked(ManageCitiesModel item) {
    ref
        .read(manageCitiesGeocodingListControllerProvider.notifier)
        .checkboxChange(item);
  }
}
