import 'package:pintersest_clone/api/auth_api.dart';
import 'package:pintersest_clone/model/login_request_model.dart';
import 'package:pintersest_clone/util/authentication_preferences.dart';

class AuthRepository {
  final AuthApi _authApi;
  final AuthenticationPreferences _authenticationPreferences;

  AuthRepository(this._authApi, this._authenticationPreferences);

  Future signIn(LoginRequestModel loginRequestModel) async {
    String token = await _authApi.signIn(loginRequestModel);
    await _authenticationPreferences.setAccessToken(token);
  }
}
