import 'package:json_annotation/json_annotation.dart';

abstract class BaseModel {
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
}
