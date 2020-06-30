import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/users_repository.dart';
import 'package:pintersest_clone/view/main/account_widget/bloc/account_event.dart';
import 'package:pintersest_clone/view/main/account_widget/bloc/account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc(this._usersRepository);

  final UsersRepository _usersRepository;

  @override
  AccountState get initialState => LoadingState();

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is LoadData) {
      yield LoadingState();
      try {
        final user = await _usersRepository.getAccountInfo();
        yield LoadedState(user);
      } on Exception catch (e) {
        yield ErrorSate(e);
      }
    }
  }
}