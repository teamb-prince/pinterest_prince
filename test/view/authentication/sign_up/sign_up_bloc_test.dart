import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pintersest_clone/model/sign_up_request_model.dart';
import 'package:pintersest_clone/view/authentication/login_form_widget/bloc/login_state.dart';
import 'package:pintersest_clone/view/authentication/sign_up_form_widget/bloc/sign_up_bloc.dart';
import 'package:pintersest_clone/view/authentication/sign_up_form_widget/bloc/sign_up_event.dart';

import '../mock_auth_repository.dart';

const SignUpRequestModel mockSignUpRequest = SignUpRequestModel(
    email: 'test@email.com', password: 'password', confirmPassword: 'password');

void main() {
  MockAuthRepository mockAuthRepository;

  group('SignUpBloc test', () {
    setUp(() async {
      mockAuthRepository = MockAuthRepository();
    });

    blocTest(
        'emit [InitialState(), LoadingState(), SuccessState()] when sign up request will succeed',
        build: () async {
      when(mockAuthRepository.signUp(any))
          .thenAnswer((_) => Future.value(null));

      return SignUpBloc(mockAuthRepository);
      // ignore: missing_return
    }, act: (bloc) {
      bloc.add(SignUp(signUpRequestModel: mockSignUpRequest));
    }, skip: 0, expect: [InitialState(), LoadingState(), SuccessState()]);

    blocTest(
        'emit [InitialState(), LoadingState(), ErrorState()] when sign up request will fail',
        build: () async {
      when(mockAuthRepository.signUp(any))
          .thenAnswer((_) => Future.error(Exception()));

      return SignUpBloc(mockAuthRepository);
      // ignore: missing_return
    }, act: (bloc) {
      bloc.add(SignUp(signUpRequestModel: mockSignUpRequest));
    }, skip: 0, expect: [InitialState(), LoadingState(), isA<ErrorState>()]);
  });
}
