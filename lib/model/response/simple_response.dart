import 'package:json_annotation/json_annotation.dart';
import 'package:mapallo/model/response/base_response.dart';

part 'simple_response.g.dart';

@JsonSerializable()
class SimpleResponse extends BaseResponse {
  // JSON
  SimpleResponse();

  factory SimpleResponse.fromJson(Map<String, dynamic> json) =>
      _$SimpleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleResponseToJson(this);
}