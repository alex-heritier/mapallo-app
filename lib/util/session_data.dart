import 'package:mapallo/models/user.dart';

abstract class SessionData {
  static String token;
  static User user;

  static String getSessionToken() => token;
  static User getUser() => user;
}
