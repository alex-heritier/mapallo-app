import 'package:json_annotation/json_annotation.dart';

abstract class BaseResponse {
  @JsonKey(name: 'req_stat')
  int reqStat;
  @JsonKey(name: 'error_msg')
  String errorMessage;
}
