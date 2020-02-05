import 'package:json_annotation/json_annotation.dart';

import '../user.dart';
import 'base_response.dart';

part 'signup_response.g.dart';

@JsonSerializable()
class SignupResponse extends BaseResponse {
  @JsonKey(name: 'token')
  String token;
  @JsonKey(name: 'user')
  User user;

  // JSON
  SignupResponse();

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}
