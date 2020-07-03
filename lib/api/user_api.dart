import 'dart:convert';

import 'package:pintersest_clone/api/api_client.dart';
import 'package:pintersest_clone/model/user_model.dart';

abstract class UsersApi {
  Future<UserModel> getUser(String id);

  Future<UserModel> getAccountInfo();

  Future<List<UserModel>> getUsers();
}

class DefaultUsersApi extends UsersApi {
  final ApiClient _apiClient;

  DefaultUsersApi(this._apiClient);

  @override
  Future<UserModel> getUser(String id) async {
    final response = await _apiClient.get('/users/$id');
    return UserModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  @override
  Future<UserModel> getAccountInfo() async {
    final response = await _apiClient.get('/profile/user');
    return UserModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await _apiClient.get('/users');
    return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
        .map((pin) => UserModel.fromJson(pin))
        .toList();
  }
}
