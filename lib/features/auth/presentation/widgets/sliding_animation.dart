import 'package:flutter/material.dart';

import './../../../../core/core.dart';

class SlidingAnimation extends StatelessWidget {
  const SlidingAnimation({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final height = context.screenSize.height;
    return Scaffold(
      backgroundColor: context.theme.colorScheme.primary,
      body: TweenAnimationBuilder(
        curve: Curves.easeInOutBack,
        tween: Tween<double>(begin: -height, end: -50),
        duration: const Duration(seconds: 2),
        builder: (context, value, _) {
          return Transform(
            transform: Matrix4.translationValues(
              0,
              -(double.parse(value.toString())),
              0,
            ),
            child: child,
          );
        },
      ),
    );
  }
}
