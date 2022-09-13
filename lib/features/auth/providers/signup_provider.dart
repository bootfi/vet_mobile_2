import 'package:flutter/cupertino.dart';
import '../../../core/core.dart';
import '../auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider, Reader;

class SignupProvider {
  SignupProvider(this.read) : _repo = read(authRepoProvider);
  final Reader read;
  final AuthRepo _repo;
  userSignup(SignupModel signupModel) async {
    try {
      read(requestStatusProvider.notifier).update(
          (state) => RequestStatusModel(requestStatus: RequestStatus.loading));
      final signupBody = signupModel.toJson();
      final result = await _repo.userSignup(signupBody);
      if (result.success) {
        read(requestStatusProvider.notifier).update((state) =>
            RequestStatusModel(
                requestStatus: RequestStatus.sucess, message: result.message));
      } else {
        read(requestStatusProvider.notifier).update((state) =>
            RequestStatusModel(
                requestStatus: RequestStatus.error, message: result.message));
      }
    } catch (e) {
      debugPrint(e.toString());
      read(requestStatusProvider.notifier).update(
          (state) => RequestStatusModel(requestStatus: RequestStatus.error));
    }
  }
}

final signupProvider = Provider<SignupProvider>((ref) {
  return SignupProvider(ref.read);
});
