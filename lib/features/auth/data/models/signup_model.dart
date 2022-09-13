import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_model.freezed.dart';
part 'signup_model.g.dart';

@freezed
class SignupModel with _$SignupModel {
  factory SignupModel({
    required String name,
    required String email,
    required String gender,
    required String mobile,
    required String address,
    required String password,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'password_confirmation')
        required String passwordConfirmation,
  }) = _SignupModel;

  factory SignupModel.fromJson(Map<String, dynamic> json) =>
      _$SignupModelFromJson(json);
}
