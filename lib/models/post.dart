import 'package:json_annotation/json_annotation.dart';
import 'package:mapallo/models/base_model.dart';
import 'package:mapallo/models/pin.dart';
import 'package:mapallo/models/user.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends BaseModel {
  @JsonKey(name: 'user_id')
  int userID;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'text')
  String text;
  @JsonKey(name: 'user')
  User user;
  @JsonKey(name: 'pin')
  Pin pin;

  // JSON
  Post();

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
