abstract class SessionData {
  static String token;
  static Map<String, dynamic> user;

  static String getSessionToken() => token;
  static Map<String, dynamic> getUser() => user;
}
