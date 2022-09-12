import '../core.dart';

class RequestStatusModel {
  RequestStatusModel({required this.requestStatus, this.message = ''});
  final RequestStatus requestStatus;
  final String message;
}
