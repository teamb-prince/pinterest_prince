import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/pins_repository.dart';

import 'bloc.dart';

class SimilarPinsBloc extends Bloc<SimilarPinsEvent, SimilarPinsState> {
  final PinsRepository _pinsRepository;

  SimilarPinsBloc(this._pinsRepository);

  @override
  SimilarPinsState get initialState => LoadingState();

  @override
  Stream<SimilarPinsState> mapEventToState(SimilarPinsEvent event) async* {
    if (event is LoadData) {
      yield LoadingState();
      try {
        final pins =
            await _pinsRepository.getPins(label: event.label, limit: 10);

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
