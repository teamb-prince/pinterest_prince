//user一覧を取る処理
//pinsの処理

import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/data/users_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';

import 'bloc.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  FollowBloc(this._usersRepository, this._pinsRepository);

  final UsersRepository _usersRepository;
  final PinsRepository _pinsRepository;

  @override
  FollowState get initialState => LoadingState();

  @override
  Stream<FollowState> mapEventToState(FollowEvent event) async* {
    if (event is LoadData) {
      yield LoadingState();
      try {
        final users = await _usersRepository.getUsers();

        final pins = <String, List<PinModel>>{};
        for (var i = 0; i < users.length; i++) {
          pins[users[i].id] =
              await _pinsRepository.getPins(userId: users[i].id, limit: 4);
        }
        yield LoadedDataState(users, pins);
      } on Exception catch (e) {
        yield ErrorState(e);
      }
    }
  }
}
