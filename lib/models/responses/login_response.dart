import 'package:json_annotation/json_annotation.dart';

import '../user.dart';
import 'base_response.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends BaseResponse {
  @JsonKey(name: 'token')
  String token;
  @JsonKey(name: 'user')
  User user;

  // JSON
  LoginResponse();

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
