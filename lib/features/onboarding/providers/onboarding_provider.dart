import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/core.dart';

class OnboardingNotifier extends StateNotifier<int> {
  OnboardingNotifier(this.ref) : super(0);
  final Ref ref;
  PageController pageController = PageController(initialPage: 0);

  onPageChanged(int? index) {
    if (index != null) {
      state = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    } else {
      state += 1;
      pageController.animateToPage(state,
          duration: const Duration(milliseconds: 800), curve: Curves.easeIn);
    }
  }

  setIsFirst() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    prefs.setBool(SharedPrefrenceKeys.isFirst.name, false);
  }
}

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, int>((ref) {
  return OnboardingNotifier(ref);
});
