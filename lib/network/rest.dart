import 'dart:async';
import 'dart:convert';

import 'package:mapallo/util/config.dart';
import 'package:http/http.dart' as http;
import 'package:mapallo/util/session_data.dart';

enum RESTMethod { GET, POST, DELETE }

abstract class REST {
  static const DEFAULT_RESPONSE_ERROR = {
    'req_stat': 401,
    'error_msg':
        'client-side decoding error (Most likely an exception occured server-side)'
  };

  static int _reqCounter = 0;

  static Map<String, String> getDefaultHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'token': SessionData.getSessionToken()
    };
  }

  static Future<http.Response> performAction(
      String partialURL, RESTMethod method,
      [Map<String, dynamic> params = const {}]) {
    final int requestID = _reqCounter++;
    final Map<String, String> headers = getDefaultHeaders();
    final jsonParams = json.encode(params);
    final url =
        _generateURL(partialURL, method == RESTMethod.GET ? params : {});

    final methodName = method.toString().split('.').last;
    final displayData = method == RESTMethod.GET ? '' : jsonParams;
    print(
        '[$requestID] $methodName $url ${displayData.isNotEmpty ? '-' : ''} $displayData');

    Function httpFunction;
    switch (method) {
      case RESTMethod.GET:
        httpFunction = http.get;
        break;
      case RESTMethod.DELETE:
        httpFunction = http.delete;
        break;
      case RESTMethod.POST:
        httpFunction =
            (u, {headers}) => http.post(u, headers: headers, body: jsonParams);
        break;
    }
    final future = httpFunction(url, headers: headers);
    future.then(
        (http.Response response) => print('[$requestID] ${response.body}'));

    return future;
  }

  /// Make a POST request and return the JSON decoded response body
  static Future<Map<String, dynamic>> post(String partialURL,
      [Map<String, dynamic> params = const {}]) async {
    return performAction(partialURL, RESTMethod.POST, params)
        .then((http.Response response) => _decodeResponse(response.body));
  }

  /// Make a GET request and return the JSON decoded response body
  static Future<Map<String, dynamic>> get(String partialURL,
      [Map<String, dynamic> params = const {}]) async {
    return performAction(partialURL, RESTMethod.GET, params)
        .then((http.Response response) => _decodeResponse(response.body));
  }

  /// Make a DELETE request and return the JSON decoded response body
  static Future<Map<String, dynamic>> delete(String partialURL,
      [Map<String, dynamic> params = const {}]) async {
    return performAction(partialURL, RESTMethod.DELETE, params)
        .then((http.Response response) => _decodeResponse(response.body));
  }

  /// Attempts to json decode response body, or return a default error Map if invalid json
  static Map<String, dynamic> _decodeResponse(String responseBody) {
    Map result;
    try {
      result = jsonDecode(responseBody);
    } catch (e) {
      result = DEFAULT_RESPONSE_ERROR;
    }
    return result;
  }

  /// Strip leading and trailing forward slashes
  static String _cleanPartialURL(String partialURL) {
    partialURL = partialURL.trim();
    if (partialURL.startsWith('/'))
      partialURL = partialURL.substring(1, partialURL.length);
    if (partialURL.endsWith('/'))
      partialURL = partialURL.substring(0, partialURL.length - 1);

    return partialURL.trim();
  }

  /// Stringify non-String params
  static Map<String, String> _stringifyMap(Map<String, dynamic> map) {
    return map.map((String key, value) => MapEntry(key, '$value'));
  }

  /// Create correct Uri depending on current value of mapallo_HOST
  static Uri _generateURL(String partialURL,
      [Map<String, dynamic> urlParams = const {}]) {
    final host = Config.getHost();

    final String cleanPartialURL = _cleanPartialURL(partialURL);
    final params = _stringifyMap(urlParams);

    Uri url;
    switch (host) {
      case Config.ANDROID_LOCALHOST:
      case Config.IOS_LOCALHOST:
        url = Uri.http(host, cleanPartialURL, params);
        break;
      case Config.DEV_HOST:
      case Config.STAGE_HOST:
      case Config.PROD_HOST:
        url = Uri.https(host, cleanPartialURL, params);
        break;
      default:
        url = Uri.https(Config.DEV_HOST, cleanPartialURL, params);
        break;
    }

    return url;
  }
}
