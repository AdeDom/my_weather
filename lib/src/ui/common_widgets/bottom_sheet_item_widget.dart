import 'package:flutter/material.dart';

class BottomSheetItemWidget extends StatelessWidget {
  const BottomSheetItemWidget({
    super.key,
    required this.title,
    required this.isCheck,
    required this.onTap,
  });

  final String title;
  final bool isCheck;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: isCheck ? Theme.of(context).colorScheme.primary : null,
                ),
          ),
          const Spacer(),
          if (isCheck) ...[
            Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ],
      ),
    );
  }
}
