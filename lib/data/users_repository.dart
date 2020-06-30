import 'package:pintersest_clone/api/users_api.dart';
import 'package:pintersest_clone/model/user_model.dart';

class UsersRepository {
  UsersRepository(this._usersApi);

  final UsersApi _usersApi;

  Future<UserModel> getAccountInfo() => _usersApi.getAccountInfo();
}