import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pintersest_clone/api/errors/error.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/model/pin_request_model.dart';
import 'package:pintersest_clone/view/main/edit_crawling_image_widget/bloc/edit_crawling_image_bloc.dart';
import 'package:pintersest_clone/view/main/edit_crawling_image_widget/bloc/edit_crawling_image_event.dart';
import 'package:pintersest_clone/view/main/edit_crawling_image_widget/bloc/edit_crawling_image_state.dart';

class MockPinRepository extends Mock implements PinsRepository {}

void main() {
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
    board: 'boardId',
  );

  group('EditCrawlingImageBloc test', () {
    setUp(() async {
      mockPinRepository = MockPinRepository();
    });

    blocTest<EditCrawlingImageBloc, EditCrawlingImageEvent,
        EditCrawlingImageState>(
      'emit [LoadingState(), SavedPinState()] when request will succeed',
      build: () async {
        when(mockPinRepository.savePin(any))
            .thenAnswer((_) => Future.value(_pinModel));

        return EditCrawlingImageBloc(mockPinRepository);
      },
      // ignore: missing_return
      act: (bloc) {
        bloc.add(SavePin(pinRequestModel: _pinRequestModel));
      },
      skip: 0,
      expect: <EditCrawlingImageState>[LoadingState(), SavedPinState()],
    );

    blocTest<EditCrawlingImageBloc, EditCrawlingImageEvent,
        EditCrawlingImageState>(
      'emit [LoadingState(), ErrorState()] when request will succeed',
      build: () async {
        when(mockPinRepository.savePin(any))
            .thenAnswer((_) => Future.error(UnauthorizedError()));

        return EditCrawlingImageBloc(mockPinRepository);
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
