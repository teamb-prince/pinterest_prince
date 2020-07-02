import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/api/errors/error.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/data/users_repository.dart';
import 'package:pintersest_clone/model/user_model.dart';

import 'bloc.dart';

class PinDetailBloc extends Bloc<PinDetailEvent, PinDetailState> {
  PinDetailBloc(this._usersRepository, this._pinsRepository);

  final UsersRepository _usersRepository;
  final PinsRepository _pinsRepository;

  @override
  PinDetailState get initialState => LoadingState();

  @override
  Stream<PinDetailState> mapEventToState(PinDetailEvent event) async* {
    if (event is LoadData) {
      yield LoadingState();
      UserModel user;
      try {
        // ここのuserの扱いが若干怖い。そもそもエラーにgetPinの404エラーでLoadedStateを判定しているのが若干怪しい気もする…
        user = await _usersRepository.getUser(event.userId);

        final tokenUser = await _usersRepository.getAccountInfo();
        await _pinsRepository.getPin(event.pinId, userId: tokenUser.id);
        yield LoadedState(user, true);
      } on NotFoundError catch (e) {
        yield LoadedState(user, false);
      } on Exception catch (e) {
        yield ErrorState(e);
      }
    }
  }
}
