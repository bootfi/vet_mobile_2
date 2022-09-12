import 'package:http_interceptor/http_interceptor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider, ProviderRef;
import '../../../../core/core.dart';
import 'dart:convert' show json;

import '../../../settings/settings.dart';

class AuthRepo {
  final ProviderRef<AuthRepo> _ref;
  final InterceptedClient http;
  AuthRepo(this._ref) : http = _ref.read(httpProvider);

  Future<ResponseModel> userLogin(Map<String, dynamic> body) async {
    final apiUrl = await _ref.watch(
      configurationsProvider.future.select(
        (config) async {
          return (await config).apiUrl;
        },
      ),
    );
    final locale = "?locale=${_ref.read(currentLocaleProvider)!.languageCode}";
    final url = '$apiUrl$customerLogin$locale';
    final response = await http.post(Uri.parse(url), body: body);
    final data = json.decode(response.body);
    final result = ResponseModel.fromJson(data);
    return result;
  }
}

final authRepoProvider = Provider<AuthRepo>((ref) {
  return AuthRepo(ref);
});
