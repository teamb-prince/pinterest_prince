import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/auth_repository.dart';
import 'package:pintersest_clone/view/authentication/sign_up_form_widget/bloc/sign_up_event.dart';
import 'package:pintersest_clone/view/authentication/sign_up_form_widget/bloc/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._authRepository);

  final AuthRepository _authRepository;

  @override
  SignUpState get initialState => InitialState();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUp) {
      yield LoadingState();
      try {
        final userModel =
            await _authRepository.signUp(event.signUpRequestModel);

        yield SuccessState(userModel);
      } on Exception catch (e) {
        print(e);
        yield ErrorState(e);
      }
    }
  }
}
