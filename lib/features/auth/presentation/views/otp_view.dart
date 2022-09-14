import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useTextEditingController;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vet_mobile/features/auth/auth.dart';

import '../../../../core/core.dart';

class OTPView extends HookConsumerWidget {
  OTPView({Key? key}) : super(key: key);
  final otpFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpController = useTextEditingController();

    final primaryColor = context.theme.colorScheme.primary;
    final requestStatus = ref.watch(requestStatusProvider);
    ref.listen<RequestStatusModel>(requestStatusProvider,
        (perivousStatus, currentStatus) {
      if (currentStatus.requestStatus == RequestStatus.error ||
          currentStatus.requestStatus == RequestStatus.sucess) {
        showVetToast(currentStatus, context);
        if (currentStatus.requestStatus == RequestStatus.sucess) {
          context.pushReplacment(LoginView());
        }
      }
    });
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          width: context.screenSize.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 50,
                ),
                SvgPicture.asset(appLogo),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: SvgPicture.asset(
                    otpVerification,
                    width: 220,
                  ),
                ),
                Text(
                  context.locale.enterOTP,
                  style: context.textTheme.headline5!
                      .copyWith(color: context.theme.colorScheme.primary),
                ),
                Text(
                  context.locale.enterOTPSentToYou,
                  style: context.textTheme.bodySmall,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Form(
                    key: otpFormKey,
                    child: SizedBox(
                      width: 270,
                      child: PinCodeTextField(
                        autoDisposeControllers: false,
                        controller: otpController,
                        hintCharacter: '0',
                        autovalidateMode: AutovalidateMode.disabled,
                        cursorColor: primaryColor,
                        pinTheme: PinTheme(
                          activeColor: primaryColor,
                          inactiveColor: primaryColor.withOpacity(0.5),
                          selectedColor: primaryColor,
                        ),
                        appContext: context,
                        length: 6,
                        keyboardType: TextInputType.number,
                        onChanged: (c) {},
                        validator: (otp) {
                          if (otp!.length == 6) {
                            return null;
                          }

                          return context.locale.otpValidation;
                        },
                        errorTextSpace: 35,
                        errorTextDirection: context.locale.localeName == 'ar'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                      ),
                    ),
                  ),
                ),
                VetButton(
                  title: context.locale.continu,
                  loading: requestStatus.requestStatus == RequestStatus.loading,
                  onPressed: () async {
                    if (otpFormKey.currentState!.validate()) {
                      await ref.read(otpProvider).verifyOTP(otpController.text);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
