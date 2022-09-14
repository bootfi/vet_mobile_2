import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core.dart';
import '../../../auth/auth.dart';
import '../../onboarding.dart';

class OnboardingButton extends ConsumerWidget {
  const OnboardingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        TweenAnimationBuilder(
          curve: Curves.easeInOutBack,
          tween:
              Tween<double>(begin: 0, end: ref.watch(onboardingProvider) + 1),
          duration: const Duration(milliseconds: 1000),
          builder: (context, double value, child) {
            return CustomPaint(
              size: const Size(80, 80),
              painter: MyPainter(
                defaultColor: Colors.grey[300]!,
                fillColor: context.theme.colorScheme.primary,
                progress: value,
              ),
            );
          },
        ),
        Positioned.fill(
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: ref.read(onboardingProvider) != 3
                ? () async {
                    await ref
                        .read(onboardingProvider.notifier)
                        .onPageChanged(null);
                  }
                : () {
                    unawaited(
                      ref.read(onboardingProvider.notifier).setIsFirst(),
                    );
                    context.pushReplacment(LoginView());
                  },
            child: Icon(
              ref.watch(onboardingProvider) != 3
                  ? Icons.arrow_forward_ios_rounded
                  : Icons.check,
              color: context.theme.colorScheme.primary,
              size: 30,
            ),
          ),
        )
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  final double progress;
  final Color defaultColor;
  final Color fillColor;

  MyPainter({
    required this.progress,
    required this.defaultColor,
    required this.fillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 15.0;
    final circleCenter = Offset(size.width / 2, size.height / 2);
    final circleRadius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..color = defaultColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(circleCenter, circleRadius, paint);

    final arcPaint = Paint()
      ..color = fillColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(center: circleCenter, radius: circleRadius),
      -math.pi / 2,
      2 * math.pi * (progress * 0.25),
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
