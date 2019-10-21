import 'package:json_annotation/json_annotation.dart';
import 'package:mapallo/models/base_model.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends BaseModel {
  @JsonKey(name: 'username')
  String username;

  // JSON
  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
