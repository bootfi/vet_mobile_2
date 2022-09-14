import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider, Reader;

import '../../../core/core.dart';
import '../auth.dart';

class OTPProvider {
  OTPProvider(this.read) : _repo = read(authRepoProvider);
  final Reader read;
  final AuthRepo _repo;
  Future<void> verifyOTP(String otp) async {
    try {
      read(requestStatusProvider.notifier).update(
        (state) => RequestStatusModel(requestStatus: RequestStatus.loading),
      );
      final result = await _repo.otpVerification(otp);
      if (result.success) {
        read(requestStatusProvider.notifier).update(
          (state) => RequestStatusModel(
            requestStatus: RequestStatus.sucess,
            message: result.message,
          ),
        );
      } else {
        read(requestStatusProvider.notifier).update(
          (state) => RequestStatusModel(
            requestStatus: RequestStatus.error,
            message: result.message,
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      read(requestStatusProvider.notifier).update(
        (state) => RequestStatusModel(requestStatus: RequestStatus.error),
      );
    }
  }
}

final otpProvider = Provider.autoDispose<OTPProvider>((ref) {
  return OTPProvider(ref.read);
});
