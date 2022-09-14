import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/core.dart';

class OnboardingNotifier extends StateNotifier<int> {
  OnboardingNotifier(this.ref) : super(0);
  final Ref ref;
  PageController pageController = PageController(initialPage: 0);

  Future<void> onPageChanged(int? index) async {
    if (index != null) {
      state = index;
      await pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    } else {
      state += 1;
      await pageController.animateToPage(
        state,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeIn,
      );
    }
  }

  Future<void> setIsFirst() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setBool(SharedPrefrenceKeys.isFirst.name, false);
  }
}

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, int>((ref) {
  return OnboardingNotifier(ref);
});
