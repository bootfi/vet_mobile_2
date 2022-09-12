import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core.dart';

showVetToast(RequestStatusModel requestStatusModel, BuildContext context) {
  final isSuccess = requestStatusModel.requestStatus == RequestStatus.sucess;
  showToastWidget(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isSuccess ? kToastSucessColor : kToastErrorColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(isSuccess ? successToastIcon : errorToastIcon),
            Text(
              requestStatusModel.message.isEmpty
                  ? context.locale.errorMessage
                  : requestStatusModel.message,
              style: context.textTheme.bodySmall!.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      context: context,
      position: StyledToastPosition.top,
      duration: const Duration(seconds: 3),
      animDuration: const Duration(milliseconds: 200),
      animation: StyledToastAnimation.slideFromTop,
      reverseAnimation: StyledToastAnimation.slideFromTop,
      curve: Curves.easeInOutBack);
}
