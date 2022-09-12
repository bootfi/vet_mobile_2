import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core.dart';

// To change the server use
// ref.read(serverProvider.notifier).state = 'prod';
// Use 'prod', 'dev', or 'testing'
final serverProvider = StateProvider<String>((ref) {
  return 'dev';
});
final requestStatusProvider =
    StateProvider.autoDispose<RequestStatusModel>((ref) {
  return RequestStatusModel(requestStatus: RequestStatus.init);
});
