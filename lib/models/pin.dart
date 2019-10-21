import 'package:json_annotation/json_annotation.dart';
import 'package:mapallo/models/base_model.dart';
import 'package:mapallo/models/user.dart';

part 'pin.g.dart';

@JsonSerializable()
class Pin extends BaseModel {
  @JsonKey(name: 'user_id')
  int userID;
  @JsonKey(name: 'lat')
  double lat;
  @JsonKey(name: 'lng')
  double lng;
  @JsonKey(name: 'pinnable_type')
  String pinnableType;
  @JsonKey(name: 'pinnable_id')
  int pinnableID;
  @JsonKey(name: 'user')
  User user;
  @JsonKey(name: 'pinnable')
  Map<String, dynamic> pinnable;

  // JSON
  Pin();

  factory Pin.fromJson(Map<String, dynamic> json) => _$PinFromJson(json);

  Map<String, dynamic> toJson() => _$PinToJson(this);
}
