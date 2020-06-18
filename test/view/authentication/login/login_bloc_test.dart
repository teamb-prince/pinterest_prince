import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pintersest_clone/data/auth_repository.dart';

import 'package:mockito/mockito.dart';
import 'package:pintersest_clone/model/login_request_model.dart';
import 'package:pintersest_clone/view/authentication/login_widget/bloc/login_bloc.dart';
import 'package:pintersest_clone/view/authentication/login_widget/bloc/login_event.dart';
import 'package:pintersest_clone/view/authentication/login_widget/bloc/login_state.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

final LoginRequestModel mockLoginRequest =
    LoginRequestModel(email: 'mock@email.com', password: 'password');

void main() {
  MockAuthRepository mockAuthRepository;

  group('LoginBloc test', () {
    setUp(() async {
      mockAuthRepository = MockAuthRepository();
    });

    blocTest(
        'emit [InitialState(), LoadingState(), SuccessState()] when login request will succeed',
        build: () async {
      when(mockAuthRepository.signIn(any))
          .thenAnswer((_) => Future.value(null));

      return LoginBloc(mockAuthRepository);
    }, act: (bloc) {
      bloc.add(Login(loginRequestModel: mockLoginRequest));
    }, skip: 0, expect: [InitialState(), LoadingState(), SuccessState()]);

    blocTest(
        'emit [InitialState(), LoadingState(), ErrorState()] when login request will fail',
        build: () async {
      when(mockAuthRepository.signIn(any))
          .thenAnswer((_) => Future.error(Exception()));

      return LoginBloc(mockAuthRepository);
    }, act: (bloc) {
      bloc.add(Login(loginRequestModel: mockLoginRequest));
    }, skip: 0, expect: [InitialState(), LoadingState(), isA<ErrorState>()]);
  });
}
