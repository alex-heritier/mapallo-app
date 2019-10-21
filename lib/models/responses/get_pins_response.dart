import 'package:json_annotation/json_annotation.dart';

import '../pin.dart';
import '../post.dart';
import '../user.dart';
import 'base_response.dart';

part 'get_pins_response.g.dart';

@JsonSerializable()
class GetPinsResponse extends BaseResponse {
  @JsonKey(name: 'pins')
  List<Pin> pins;

  // JSON
  GetPinsResponse();

  factory GetPinsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPinsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPinsResponseToJson(this);
}
