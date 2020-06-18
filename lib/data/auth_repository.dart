import 'package:pintersest_clone/api/auth_api.dart';
import 'package:pintersest_clone/model/sign_in_request_model.dart';
import 'package:pintersest_clone/util/authentication_preferences.dart';

class AuthRepository {
  final AuthApi _authApi;
  final AuthenticationPreferences _authenticationPreferences;

  AuthRepository(this._authApi, this._authenticationPreferences);

  Future signIn(SignInRequestModel signInRequestModel) async {
    String token = await _authApi.signIn(signInRequestModel);
    await _authenticationPreferences.setAccessToken(token);
  }
}
