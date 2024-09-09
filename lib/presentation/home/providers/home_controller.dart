import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

@riverpod
class HomePageViewIndexController extends _$HomePageViewIndexController {
  @override
  int build() {
    return 0;
  }

  void onPageViewChange(int value) {
    state = value;
  }
}
