import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/view/main/home_widget/bloc/home_bloc.dart';
import 'package:pintersest_clone/view/main/home_widget/bloc/home_event.dart';
import 'package:pintersest_clone/view/main/home_widget/bloc/home_state.dart';

class MockPinsRepository extends Mock implements PinsRepository {}

void main() {
  MockPinsRepository mockPinsRepository;
  const mockPins = [
    PinModel(
        id: 'id 1',
        url: 'url 1',
        title: 'title 1',
        imageUrl: 'imageUrl 1',
        board: 'board 1',
        description: 'description 1'),
    PinModel(
        id: 'id 2',
        url: 'url 2',
        title: 'title 2',
        imageUrl: 'imageUrl 2',
        board: 'board 2',
        description: 'description 2'),
  ];

  final List<PinModel> noPins = [];

  group('HomeBloc test', () {
    setUp(() async {
      mockPinsRepository = MockPinsRepository();
    });

    blocTest<HomeBloc, HomeEvent, HomeState>(
        'emit [LoadingState(), LoadedState()] when request will succeed',
        build: () async {
      when(mockPinsRepository.getPins())
          .thenAnswer((_) => Future.value(mockPins));

      return HomeBloc(mockPinsRepository);
      // ignore: missing_return
    }, act: (bloc) {
      bloc.add(LoadData());
    }, skip: 0, expect: <HomeState>[LoadingState(), LoadedState(mockPins)]);

    blocTest<HomeBloc, HomeEvent, HomeState>(
        'emit [LoadingState(), NoDataState()] when request will succeed, but there are no pins',
        build: () async {
      when(mockPinsRepository.getPins())
          .thenAnswer((_) => Future.value(noPins));

      return HomeBloc(mockPinsRepository);
      // ignore: missing_return
    }, act: (bloc) {
      bloc.add(LoadData());
    }, skip: 0, expect: <HomeState>[LoadingState(), NoDataState()]);

    blocTest<HomeBloc, HomeEvent, HomeState>(
        'emit [LoadingState(), ErrorState()] when request will fail',
        build: () async {
      when(mockPinsRepository.getPins())
          .thenAnswer((_) => Future.error(Exception()));

      return HomeBloc(mockPinsRepository);
      // ignore: missing_return
    }, act: (bloc) {
      bloc.add(LoadData());
    }, skip: 0, expect: <dynamic>[LoadingState(), isA<ErrorState>()]);
  });
}
