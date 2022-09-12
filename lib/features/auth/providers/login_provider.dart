import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:vet_mobile/features/auth/data/models/user_model.dart';
import '../../../core/core.dart';
import '../auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider, Reader;

class LoginProvider {
  LoginProvider(this.read) : _repo = read(authRepoProvider);
  final Reader read;
  final AuthRepo _repo;
  userLogin(String email, String password) async {
    try {
      read(requestStatusProvider.notifier).update(
          (state) => RequestStatusModel(requestStatus: RequestStatus.loading));
      final loginBody = {"email": email, "password": password};
      final result = await _repo.userLogin(loginBody);
      if (result.success) {
        final userModel = UserModel.fromJson(result.data);
        final prefs = await read(sharedPreferencesProvider.future);
        prefs.setString(
            SharedPrefrenceKeys.userModel.name, jsonEncode(userModel.toJson()));
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

final loginProvider = Provider<LoginProvider>((ref) {
  return LoginProvider(ref.read);
});
