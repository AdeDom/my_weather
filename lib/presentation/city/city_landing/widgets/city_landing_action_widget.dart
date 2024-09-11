import 'package:flutter/material.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';

class CityLandingActionWidget extends StatelessWidget {
  const CityLandingActionWidget({
    super.key,
    required this.isAddOrDelete,
    required this.onRemoveList,
    required this.onShowBottomSheet,
  });

  final bool isAddOrDelete;
  final Function() onRemoveList;
  final Function() onShowBottomSheet;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (isAddOrDelete) {
      return InkWell(
        onTap: onRemoveList,
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
        onPressed: onShowBottomSheet,
        child: const Icon(Icons.add),
      );
    }
  }
}
