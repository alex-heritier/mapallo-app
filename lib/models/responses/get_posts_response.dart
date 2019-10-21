import 'package:json_annotation/json_annotation.dart';

import '../post.dart';
import '../user.dart';
import 'base_response.dart';

part 'get_posts_response.g.dart';

@JsonSerializable()
class GetPostsResponse extends BaseResponse {
  @JsonKey(name: 'posts')
  List<Post> posts;

  // JSON
  GetPostsResponse();

  factory GetPostsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPostsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostsResponseToJson(this);
}
