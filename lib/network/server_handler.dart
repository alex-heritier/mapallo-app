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

// #########
// ## GET ##
// #########
}
