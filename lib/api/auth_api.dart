import 'dart:convert';

import 'package:pintersest_clone/api/api_client.dart';
import 'package:pintersest_clone/model/login_request_model.dart';
import 'package:pintersest_clone/model/sign_up_request_model.dart';
import 'package:pintersest_clone/model/user_model.dart';

abstract class AuthApi {
  Future<String> signIn(LoginRequestModel loginRequestModel);

  Future<UserModel> signUp(SignUpRequestModel signUpRequestModel);

  Future<void> signOut();
}

class DefaultAuthApi extends AuthApi {
  DefaultAuthApi(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<String> signIn(LoginRequestModel loginRequestModel) async {
    final response =
        await _apiClient.post('/login', body: loginRequestModel.toJson());
    return jsonDecode(response.body)['token'] as String;
  }

  @override
  Future<UserModel> signUp(SignUpRequestModel signUpRequestModel) async {
    final response =
        await _apiClient.post('/users', body: signUpRequestModel.toJson());
    return UserModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  @override
  Future<void> signOut() async {
    await _apiClient.post('logout');
  }
}
