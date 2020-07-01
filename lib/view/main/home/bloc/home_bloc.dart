import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';

import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._pinsRepository);

  final PinsRepository _pinsRepository;

  @override
  HomeState get initialState => LoadingState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadData) {
      try {
        List<PinModel> pins;
        List<PinModel> currentPins;
        if (state is LoadedState) {
          currentPins = (state as LoadedState).pins;
          pins = await _pinsRepository.getDiscoverPins(
              offset: currentPins.length, limit: 50);
          if (pins.isEmpty) {
            pins = await _pinsRepository.getDiscoverPins(offset: 0, limit: 50);
          }
        } else {
          pins = await _pinsRepository.getDiscoverPins(offset: 0, limit: 50);
          currentPins ??= [];
        }

        if (pins.isEmpty) {
          yield NoDataState();
        } else {
          yield LoadedState(currentPins + pins);
        }
      } on Exception catch (e) {
        yield ErrorState(e);
      }
    }
  }
}
