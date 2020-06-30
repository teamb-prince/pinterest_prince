import 'dart:convert';

import 'package:pintersest_clone/api/api_client.dart';
import 'package:pintersest_clone/model/user_model.dart';

abstract class UsersApi {
  Future<UserModel> getAccountInfo();
}

class DefaultUsersApi extends UsersApi {
  DefaultUsersApi(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<UserModel> getAccountInfo() async {
    final response = await _apiClient.get('/profile/user');
    return UserModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
}
