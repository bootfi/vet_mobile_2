import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    Key? key,
    required this.title,
    required this.clickableText,
    this.onClick,
  }) : super(key: key);
  final String title;
  final String clickableText;
  final Function()? onClick;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: title,
          style: context.textTheme.bodyMedium,
          children: [
            TextSpan(
                text: clickableText,
                style: context.textTheme.bodyLarge!
                    .copyWith(color: context.theme.colorScheme.primary),
                recognizer: TapGestureRecognizer()..onTap = onClick),
          ],
        ),
      ),
    );
  }
}
