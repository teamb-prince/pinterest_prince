import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationPreferences {
  static const _authTokenKey = 'authToken';

  Future<String> getAccessToken() async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString(_authTokenKey);
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
