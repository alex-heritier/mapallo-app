import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:mapallo/util/config.dart';
import 'package:flutter/material.dart';

abstract class Util {
  static const String PLAYER_SELECT_CHANNEL_ACTION_PLAY = 'PLAY';
  static const String PLAYER_SELECT_CHANNEL_ACTION_REMOTE = 'REMOTE';

  static String _platformStorageDirectoryPath;

  static String _deviceID;
  static String _deviceModel;
  static String _deviceBrand;

  static Random _random;

  static Directory getPlatformStorageDirectory() {
    return Directory(_platformStorageDirectoryPath);
  }

  static Directory getBaseAppDirectory() {
    return Directory("${getPlatformStorageDirectory().path}/beat45/");
  }

  static String getDeviceID() => "${getPlatformCode()}-$_deviceID";

  static String getDeviceModel() => _deviceModel;

  static String getDeviceBrand() => _deviceBrand;

  static String getPlatformCode() {
    final String id = Platform.operatingSystem;
    return id.substring(0, min(3, id.length));
  }

  static Random getRandom() => _random;

  static Color getRandomColor() {
    return Color.fromRGBO(getRandom().nextInt(0xFF), getRandom().nextInt(0xFF),
        getRandom().nextInt(0xFF), 0x01);
  }

  static String prettyJSON(var data) {
    const encoder = JsonEncoder.withIndent("     ");
    return encoder.convert(data);
  }

  static bool isDebug() {
    return Config.getDefaultHost() != Config.PROD_HOST;
  }

  static bool isPhone(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide < 600;
  }

  static bool isTablet(BuildContext context) {
    return !isPhone(context);
  }

  static IconData getDeviceIcon(BuildContext context) {
    var icon = Icons.phone_android;
    if (Platform.isAndroid)
      icon = isPhone(context) ? Icons.phone_android : Icons.tablet_android;
    else if (Platform.isIOS)
      icon = isPhone(context) ? Icons.phone_iphone : Icons.tablet_mac;
    return icon;
  }
}
