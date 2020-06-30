import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pintersest_clone/data/users_repository.dart';
import 'package:pintersest_clone/model/user_model.dart';
import 'package:pintersest_clone/view/main/account_widget/bloc/account_bloc.dart';
import 'package:pintersest_clone/view/main/account_widget/bloc/account_event.dart';
import 'package:pintersest_clone/view/main/account_widget/bloc/account_state.dart';

class MockUsersRepository extends Mock implements UsersRepository {}

void main() {
  MockUsersRepository mockUsersRepository;

  final mockUser = UserModel(
      id: 'mrypq',
      firstName: 'めろ子',
      lastName: 'めろ田',
      profileImageUrl:
          'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/profile_image.jpeg',
      description: 'めろぴっぴです',
      location: 'めろ王国',
      web: 'https://github.com/mrypq',
      createdAt: DateTime.parse('2020-01-01T10:10:10Z'));

  group('AccountBloc test', () {
    setUp(() async {
      mockUsersRepository = MockUsersRepository();
    });

    blocTest('emit [LoadingState(), LoadedState()] when request will succeed',
        build: () async {
      when(mockUsersRepository.getAccountInfo())
          .thenAnswer((_) => Future.value(mockUser));

      return AccountBloc(mockUsersRepository);
      // ignore: missing_return
    }, act: (bloc) {
      bloc.add(LoadData());
    }, skip: 0, expect: <AccountState>[LoadingState(), LoadedState(mockUser)]);

    blocTest('emit [LoadingState(), ErrorState()] when request will fail',
        build: () async {
      when(mockUsersRepository.getAccountInfo())
          .thenAnswer((_) => Future.error(Exception()));

      return AccountBloc(mockUsersRepository);
      // ignore: missing_return
    }, act: (bloc) {
      bloc.add(LoadData());
    }, skip: 0, expect: <dynamic>[LoadingState(), isA<ErrorSate>()]);
  });
}
