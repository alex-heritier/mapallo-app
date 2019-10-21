import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapallo/models/responses/base_response.dart';
import 'package:mapallo/models/responses/get_pins_response.dart';
import 'package:mapallo/models/responses/get_posts_response.dart';
import 'package:mapallo/models/responses/login_response.dart';
import 'package:mapallo/models/responses/signup_response.dart';
import 'package:mapallo/network/rest.dart';
import 'package:mapallo/util/util.dart';

abstract class ServerHandler {
  // ############
  // ## DELETE ##
  // ############
  static Future<Map<String, dynamic>> logout() {
    return REST.delete('/authenticate/');
  }

  // ##########
  // ## POST ##
  // ##########
  static Future<LoginResponse> credentialsLogin(
      String username, String password) async {
    final params = {
      'username': username,
      'password': password,
    };
    return _login(params);
  }

  static Future<LoginResponse> _login(Map params) async {
    return REST
        .post('/login.json', params)
        .then((data) => LoginResponse.fromJson(data));
  }

  static Future<SignupResponse> signup(
      String username, String password) async {
    final params = {
      'username': username,
      'password': password,
      'device_uid': Util.getDeviceID(),
      'brand': Util.getDeviceBrand(),
      'model': '${Util.getDeviceBrand()}-${Util.getDeviceModel()}'
    };
    return REST.post('/signup.json', params)
        .then((data) => SignupResponse.fromJson(data));
  }

  static Future<BaseResponse> createPost(
      String title, String text, LatLng latLng) async {
    final params = {
      'title': title,
      'text': text,
      'lat_lng': {'lat': latLng.latitude, 'lng': latLng.longitude},
    };
    return REST.post('/posts.json', params)
        .then((data) => BaseResponse.fromJson(data));
  }

// #########
// ## GET ##
// #########
  static Future<GetPostsResponse> getPosts() async {
    return REST.get('/posts.json')
        .then((data) => GetPostsResponse.fromJson(data));
  }

  static Future<GetPinsResponse> getPins() async {
    return REST.get('/pins.json')
        .then((data) => GetPinsResponse.fromJson(data));
  }
}
