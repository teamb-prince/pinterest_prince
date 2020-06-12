import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:mockito/mockito.dart';
import 'package:pintersest_clone/view/main/home_widget/bloc/home_bloc.dart';
import 'package:pintersest_clone/view/main/home_widget/bloc/home_event.dart';
import 'package:pintersest_clone/view/main/home_widget/bloc/home_state.dart';

class MockPinsRepository extends Mock implements PinsRepository {}

void main() {
  MockPinsRepository mockPinsRepository;
  final List<PinModel> mockPins = [
    PinModel(
        id: "id 1",
        url: "url 1",
        title: "title 1",
        imageUrl: "imageUrl 1",
        board: "board 1",
        description: "description 1"),
    PinModel(
        id: "id 2",
        url: "url 2",
        title: "title 2",
        imageUrl: "imageUrl 2",
        board: "board 2",
        description: "description 2"),
  ];

  final List<PinModel> noPins = [];

  group("HomeBloc test", () {
    setUp(() async {
      mockPinsRepository = MockPinsRepository();
    });

    blocTest("emit [LoadingState(), LoadedState()] when request will succeed",
        build: () async {
          when(mockPinsRepository.getPins())
              .thenAnswer((_) => Future.value(mockPins));

          return HomeBloc(mockPinsRepository);
        },
        act: (bloc) => bloc.add(LoadData()),
        skip: 0,
        expect: [LoadingState(), LoadedState(mockPins)]);

    blocTest(
        "emit [LoadingState(), NoDataState()] when request will succeed, but there are no pins",
        build: () async {
          when(mockPinsRepository.getPins())
              .thenAnswer((_) => Future.value(noPins));

          return HomeBloc(mockPinsRepository);
        },
        act: (bloc) => bloc.add(LoadData()),
        skip: 0,
        expect: [LoadingState(), NoDataState()]);

    blocTest(
        "emit [LoadingState(), ErrorState()] when request will fail",
        build: () async {
          when(mockPinsRepository.getPins())
              .thenAnswer((_) => Future.error(Exception()));

          return HomeBloc(mockPinsRepository);
        },
        act: (bloc) => bloc.add(LoadData()),
        skip: 0,
        expect: [LoadingState(), isA<ErrorState>()]);
  });
}
