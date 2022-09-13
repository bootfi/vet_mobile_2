import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_model.freezed.dart';
part 'response_model.g.dart';

@freezed
class ResponseModel with _$ResponseModel {
  factory ResponseModel({
    required final bool success,
    required final String message,
    required final dynamic data,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'status_code') required final int statusCode,
  }) = _ResponseModel;

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);
}
