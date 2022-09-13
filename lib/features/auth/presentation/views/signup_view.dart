import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useTextEditingController;
import '../../../../core/core.dart';
import '../../auth.dart';

// ignore: must_be_immutable
class SignupView extends HookConsumerWidget with ValidationMixin {
  SignupView({Key? key}) : super(key: key);
  final signupFormKey = GlobalKey<FormState>();
  GenderTypes selectedGender = GenderTypes.male;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fullNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final addressController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordConfirmController = useTextEditingController();
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
                  context.locale.createAccount,
                  style: context.textTheme.headline5!
                      .copyWith(color: Colors.white),
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
                    key: signupFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        // full name
                        VetTextFormField(
                          controller: fullNameController,
                          hintText: context.locale.fullName,
                          validator: (fullName) =>
                              validateFullName(fullName, context),
                        ),
                        // email
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: VetTextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            hintText: context.locale.email,
                            validator: (email) =>
                                validateRequiredEmail(email, context),
                          ),
                        ),
                        // gender
                        GenderSelector(
                          onSelect: (selectedGender) {
                            selectedGender = selectedGender;
                          },
                        ),
                        // phone
                        PhoneNumberField(controller: phoneController),
                        // address
                        VetTextFormField(
                          controller: addressController,
                          hintText: context.locale.address,
                          validator: (address) =>
                              validateAddress(address, context),
                        ),
                        // password
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: VetTextFormField(
                            controller: passwordController,
                            obscureText: true,
                            hintText: context.locale.password,
                            validator: (password) =>
                                validatePassword(password, context),
                          ),
                        ),
                        // password confirmation
                        VetTextFormField(
                          controller: passwordConfirmController,
                          obscureText: true,
                          hintText: context.locale.passwordConfirmation,
                          validator: (passwordConfirmation) =>
                              validateConfirmPassword(passwordConfirmation,
                                  passwordController.text, context),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: VetButton(
                            loading: requestStatus.requestStatus ==
                                RequestStatus.loading,
                            onPressed: () {
                              if (signupFormKey.currentState!.validate()) {
                                final signupModel = SignupModel(
                                  name: fullNameController.text,
                                  email: emailController.text,
                                  gender: selectedGender.name,
                                  mobile: phoneController.text,
                                  address: addressController.text,
                                  password: passwordController.text,
                                  passwordConfirmation:
                                      passwordConfirmController.text,
                                );
                                ref
                                    .read(signupProvider)
                                    .userSignup(signupModel);
                              }
                            },
                            title: context.locale.createAccount,
                          ),
                        ),
                        CustomRichText(
                          title: context.locale.alreadyHaveAccount,
                          clickableText: context.locale.login,
                          onClick: () {
                            context.pushReplacment(LoginView());
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
            ]),
      ),
    );
  }
}
