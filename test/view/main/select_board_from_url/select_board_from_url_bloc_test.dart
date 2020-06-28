import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pintersest_clone/api/errors/error.dart';
import 'package:pintersest_clone/data/boards_repository.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/model/pin_request_model.dart';
import 'package:pintersest_clone/view/main/select_board_from_url_widget/bloc/select_board_from_url_bloc.dart';
import 'package:pintersest_clone/view/main/select_board_from_url_widget/bloc/select_board_from_url_event.dart';
import 'package:pintersest_clone/view/main/select_board_from_url_widget/bloc/select_board_from_url_state.dart';

class MockBoardRepository extends Mock implements BoardsRepository {}

class MockPinRepository extends Mock implements PinsRepository {}

void main() {
  BoardsRepository mockBoardRepository;
  MockPinRepository mockPinRepository;
  const _pinRequestModel = PinRequestModel(
    userId: 'mrypq',
    originalUserId: 'mrypq',
    url: 'url',
    imageUrl: 'imageUrl',
    title: 'title',
    description: 'description',
    boardId: 'boardId',
  );

  const _pinModel = PinModel(
    id: 'id',
    url: 'url',
    imageUrl: 'imageUrl',
    title: 'title',
    description: 'description',
  );

  group('SelectBoardFromUrlBloc test', () {
    setUp(() async {
      mockPinRepository = MockPinRepository();
      mockBoardRepository = MockBoardRepository();
    });

    blocTest<SelectBoardFromUrlBloc, SelectBoardFromUrlEvent,
        SelectBoardFromUrlState>(
      'emit [LoadingState(), SavedPinState()] when request will succeed',
      build: () async {
        when(mockPinRepository.savePinFromUrl(any))
            .thenAnswer((_) => Future.value(_pinModel));

        return SelectBoardFromUrlBloc(mockBoardRepository, mockPinRepository);
      },
      // ignore: missing_return
      act: (bloc) {
        bloc.add(SavePin(pinRequestModel: _pinRequestModel));
      },
      skip: 0,
      expect: <SelectBoardFromUrlState>[LoadingState(), SavedPinState()],
    );

    blocTest<SelectBoardFromUrlBloc, SelectBoardFromUrlEvent,
        SelectBoardFromUrlState>(
      'emit [LoadingState(), ErrorState()] when request will succeed',
      build: () async {
        when(mockPinRepository.savePinFromUrl(any))
            .thenAnswer((_) => Future.error(UnauthorizedError()));

        return SelectBoardFromUrlBloc(mockBoardRepository, mockPinRepository);
      },
      // ignore: missing_return
      act: (bloc) {
        bloc.add(SavePin(pinRequestModel: _pinRequestModel));
      },
      skip: 0,
      expect: <dynamic>[LoadingState(), isA<ErrorState>()],
    );
  });
}
