import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/auth_repository.dart';

import 'bloc.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc(this._authRepository);

  final AuthRepository _authRepository;

  @override
  SettingState get initialState => InitialState();

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    if (event is SignOut) {
      yield LoadingState();
      try {
        await _authRepository.signOut();
        yield SuccessState();
      } on Exception catch (e) {
        yield ErrorState(e);
      }
    }
  }
}
