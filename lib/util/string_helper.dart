abstract class StringHelper {
  static bool isEmpty(final String z) {
    return z == null || z.isEmpty;
  }

  static bool isExist(final String z) {
    return !isEmpty(z);
  }

  static bool isMatch(final String a, final String b) {
    bool val = false;
    try { val = a == b;}
    catch (e) {val = false;}
    return val;
  }

  static bool isEmail(final String z) {
    const String emailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    return RegExp(emailPattern).hasMatch(z);
  }
}
