import 'package:pintersest_clone/api/auth_api.dart';
import 'package:pintersest_clone/model/login_request_model.dart';
import 'package:pintersest_clone/model/sign_up_request_model.dart';
import 'package:pintersest_clone/model/user_model.dart';
import 'package:pintersest_clone/util/authentication_preferences.dart';

class AuthRepository {
  AuthRepository(this._authApi, this._authenticationPreferences);

  final AuthApi _authApi;
  final AuthenticationPreferences _authenticationPreferences;

  Future signIn(LoginRequestModel loginRequestModel) async {
    final token = await _authApi.signIn(loginRequestModel);
    await _authenticationPreferences.setAccessToken(token);
  }

  Future<UserModel> signUp(SignUpRequestModel signUpRequestModel) =>
      _authApi.signUp(signUpRequestModel);

  Future<void> signOut() async {
    await _authApi.signOut();
    await _authenticationPreferences.clearToken();
  }
}
