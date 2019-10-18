import 'dart:io';

abstract class Config {
  // Local hosts
  static const String ANDROID_LOCALHOST =
      '10.0.2.2:3000'; // '10.0.2.2:3000';
  static const String IOS_LOCALHOST = '127.0.0.1:3000';

  // Remote hosts
  static const String DEV_HOST = 'serene-voltage-253823.appspot.com';
  static const String STAGE_HOST = 'serene-voltage-253823.appspot.com';
  static const String PROD_HOST = 'serene-voltage-253823.appspot.com';

  static String _currentHost = getDefaultHost();

  static String getPlatformLocalhost() =>
      Platform.isAndroid ? ANDROID_LOCALHOST : IOS_LOCALHOST;

  static bool isLocalhost(String host) =>
      [ANDROID_LOCALHOST, IOS_LOCALHOST].contains(host);

  static String getDefaultHost() {
    return getPlatformLocalhost();
//    return DEV_HOST;
  }

  static String getHost() => _currentHost;

  static void setHost(String host) => _currentHost = host;
}
