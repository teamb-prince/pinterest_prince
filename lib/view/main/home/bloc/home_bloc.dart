import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/pins_repository.dart';

import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PinsRepository _pinsRepository;

  HomeBloc(this._pinsRepository);

  @override
  HomeState get initialState => LoadingState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadData) {
      yield LoadingState();
      try {
        final pins = await _pinsRepository.getDiscoverPins();

        if (pins.isEmpty) {
          yield NoDataState();
        } else {
          yield LoadedState(pins);
        }
      } on Exception catch (e) {
        yield ErrorState(e);
      }
    }
  }
}
