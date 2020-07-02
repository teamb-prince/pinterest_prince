import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationPreferences {
  static const _authTokenKey = 'authToken';
  static const _expireKey = 'Expire';

  Future<String> getAccessToken() async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString(_authTokenKey);
  }

  Future<bool> isAuthenticated() async {
    final token = await getAccessToken();
    if (token?.isEmpty ?? true) {
      return false;
    }
    final payload = token.split('.')[1];
    final payloadMap = jsonDecode(utf8.decode(base64.decode(payload)));
    final expire = payloadMap[_expireKey] as int;
    if (!_compareDate(expire)) {
      await clearToken();
      return false;
    }
    return true;
  }

  bool _compareDate(int expire) {
    final now = DateTime.now();
    final expireDate = DateTime.fromMillisecondsSinceEpoch(1000 * expire);
    final diff = expireDate.difference(now);
    return diff.inMicroseconds > 0;
  }

  Future setAccessToken(String token) async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.setString(_authTokenKey, token);
  }

  Future clearToken() async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.remove(_authTokenKey);
  }
}
