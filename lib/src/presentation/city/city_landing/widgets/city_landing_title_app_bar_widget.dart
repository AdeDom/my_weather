import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/generated/locale_keys.g.dart';

class CityLandingTitleAppBarWidget extends StatelessWidget {
  const CityLandingTitleAppBarWidget({
    super.key,
    required this.isSelectAll,
    required this.selectIds,
  });

  final bool isSelectAll;
  final List<String> selectIds;

  @override
  Widget build(BuildContext context) {
    final isDeselectAll = selectIds.isEmpty;
    final countSelected = selectIds.length.toString();
    if (isSelectAll) {
      return Text(LocaleKeys.city_landing_all_selected.tr());
    } else if (!isDeselectAll) {
      return Text(
        LocaleKeys.city_landing_selected.tr(args: [countSelected]),
      );
    } else {
      return Text(LocaleKeys.city_landing_select_items.tr());
    }
  }
}
