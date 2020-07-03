import 'package:pintersest_clone/api/user_api.dart';
import 'package:pintersest_clone/model/user_model.dart';

class UsersRepository {
  UsersRepository(this._usersApi);

  final UsersApi _usersApi;

  Future<UserModel> getUser(String id) => _usersApi.getUser(id);

  Future<UserModel> getAccountInfo() => _usersApi.getAccountInfo();

  Future<List<UserModel>> getUsers() => _usersApi.getUsers();
}
