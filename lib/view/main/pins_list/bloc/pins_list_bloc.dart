import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/pins_repository.dart';

import 'bloc.dart';

class PinsListBloc extends Bloc<PinsListEvent, PinsListState> {
  PinsListBloc(this._pinsRepository);

  final PinsRepository _pinsRepository;

  @override
  PinsListState get initialState => LoadingState();

  @override
  Stream<PinsListState> mapEventToState(PinsListEvent event) async* {
    if (event is LoadData) {
      yield LoadingState();
      try {
        final pins = await _pinsRepository.getTokenUserPins();
        yield LoadedState(pins);
      } on Exception catch (e) {
        yield ErrorState(e);
      }
    }
  }
}
