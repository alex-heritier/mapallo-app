import 'package:json_annotation/json_annotation.dart';
import 'package:mapallo/model/base_model.dart';
import 'package:mapallo/model/pin.dart';
import 'package:mapallo/model/user.dart';

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
