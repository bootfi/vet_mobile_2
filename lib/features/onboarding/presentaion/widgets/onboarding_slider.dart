import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/core.dart';
import '../../onboarding.dart';

class OnboardingSlider extends ConsumerStatefulWidget {
  const OnboardingSlider({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingSliderState();
}

class _OnboardingSliderState extends ConsumerState<OnboardingSlider> {
  late List<OnboardingModel> _onboardingItems;
  @override
  void initState() {
    _onboardingItems = [
      OnboardingModel(
        title: "",
        description: "",
        image: onBoarding1,
      ),
      OnboardingModel(
        title: "",
        description: "",
        image: onBoarding2,
      ),
      OnboardingModel(
        title: "",
        description: "",
        image: onBoarding3,
      ),
      OnboardingModel(
        title: "",
        description: "",
        image: onBoarding4,
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sliderController =
        ref.read(onboardingProvider.notifier).pageController;
    return PageView.builder(
      controller: sliderController,
      onPageChanged: (pageIndex) {
        ref.read(onboardingProvider.notifier).onPageChanged(pageIndex);
      },
      itemCount: _onboardingItems.length,
      itemBuilder: (context, index) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 50),
            child: SizedBox(
              height: 200,
              child: SvgPicture.asset(
                _onboardingItems[index].image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            "قم بايجاد افضل طبيب بيطري",
            style: context.textTheme.headline5!
                .copyWith(color: context.theme.colorScheme.primary),
          ),
          const Text("نحن سوف نساعدك لتختار افضل عيادة لحيوانك الأليف"),
        ],
      ),
    );
  }
}
