import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  static Future<Map<String, dynamic>> credentialsLogin(
      String username, String password) async {
    final params = {
      'username': username,
      'password': password,
    };
    return _login(params);
  }

  static Future<Map<String, dynamic>> tokenLogin(String token) async {
    final params = {
      'token': token,
      'device_uid': Util.getDeviceID(),
      'brand': Util.getDeviceBrand(),
      'model': '${Util.getDeviceBrand()}-${Util.getDeviceModel()}'
    };
    return _login(params);
  }

  static Future<Map<String, dynamic>> _login(Map params) async {
    return REST.post('/login.json', params);
  }

  static Future<Map<String, dynamic>> signup(
      String username, String password) async {
    final params = {
      'username': username,
      'password': password,
      'device_uid': Util.getDeviceID(),
      'brand': Util.getDeviceBrand(),
      'model': '${Util.getDeviceBrand()}-${Util.getDeviceModel()}'
    };
    return REST.post('/signup.json', params);
  }

  static Future<Map<String, dynamic>> createPost(
      String title, String text, LatLng latLng) async {
    final params = {
      'title': title,
      'text': text,
      'lat_lng': {'lat': latLng.latitude, 'lng': latLng.longitude},
    };
    return REST.post('/posts.json', params);
  }

// #########
// ## GET ##
// #########
  static Future<Map<String, dynamic>> getPosts() async {
    return REST.get('/posts.json');
  }

  static Future<Map<String, dynamic>> getPins() async {
    return REST.get('/pins.json');
  }
}
