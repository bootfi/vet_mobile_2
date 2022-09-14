import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useTextEditingController;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './../../../../core/core.dart';
import '../../auth.dart';

class LoginView extends HookConsumerWidget with ValidationMixin {
  LoginView({Key? key}) : super(key: key);
  final loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final requestStatus = ref.watch(requestStatusProvider);
    ref.listen<RequestStatusModel>(requestStatusProvider,
        (perivousStatus, currentStatus) {
      if (currentStatus.requestStatus == RequestStatus.error ||
          currentStatus.requestStatus == RequestStatus.sucess) {
        showVetToast(currentStatus, context);
      }
    });
    return SlidingAnimation(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              appLogo,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                context.locale.login,
                style:
                    context.textTheme.headline5!.copyWith(color: Colors.white),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: context.screenSize.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                ),
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SvgPicture.asset(
                          loginImage,
                          width: 280,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: VetTextFormField(
                          controller: emailController,
                          hintText:
                              '${context.locale.email} / ${context.locale.phone}',
                          validator: (email) =>
                              validateRequiredEmail(email, context),
                        ),
                      ),
                      VetTextFormField(
                        controller: passwordController,
                        obscureText: true,
                        hintText: context.locale.password,
                        validator: (password) =>
                            validatePassword(password, context),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          context.locale.forgetPassword,
                          style: context.textTheme.bodySmall!.copyWith(
                            color: context.theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: VetButton(
                          loading: requestStatus.requestStatus ==
                              RequestStatus.loading,
                          onPressed: () async {
                            if (loginFormKey.currentState!.validate()) {
                              await ref.read(loginProvider).userLogin(
                                    emailController.text,
                                    passwordController.text,
                                  );
                            }
                          },
                          title: context.locale.login,
                        ),
                      ),
                      CustomRichText(
                        title: context.locale.newUser,
                        clickableText: context.locale.createAccount,
                        onClick: () {
                          context.pushReplacment(SignupView());
                        },
                      ),
                      const SizedBox(
                        height: 70,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
