import 'package:pintersest_clone/api/auth_api.dart';
import 'package:pintersest_clone/model/login_request_model.dart';
import 'package:pintersest_clone/model/sign_up_request_model.dart';
import 'package:pintersest_clone/util/authentication_preferences.dart';

class AuthRepository {
  AuthRepository(this._authApi, this._authenticationPreferences);

  final AuthApi _authApi;
  final AuthenticationPreferences _authenticationPreferences;

  Future signIn(LoginRequestModel loginRequestModel) async {
    final token = await _authApi.signIn(loginRequestModel);
    await _authenticationPreferences.setAccessToken(token);
  }

  Future signUp(SignUpRequestModel signUpRequestModel) async {
    final token = await _authApi.signUp(signUpRequestModel);
    await _authenticationPreferences.setAccessToken(token);
  }
}
