import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
abstract class BaseResponse {
  @JsonKey(name: 'req_stat')
  int reqStat;
  @JsonKey(name: 'error_msg')
  String errorMessage;

  // JSON
  BaseResponse();

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
