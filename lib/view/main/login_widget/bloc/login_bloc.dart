import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/auth_repository.dart';
import 'package:pintersest_clone/view/main/login_widget/bloc/login_event.dart';
import 'package:pintersest_clone/view/main/login_widget/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc(this._authRepository);

  @override
  LoginState get initialState => InitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is Login) {
      yield LoadingState();
      try {
        await _authRepository.signIn(event.loginRequestModel);
        yield SuccessState();
      } on Exception catch (e) {
        yield ErrorState(e);
      }
    }
  }
}