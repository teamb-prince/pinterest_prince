import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'bloc.dart';

class SearchPinsListBloc
    extends Bloc<SearchPinsListEvent, SearchPinsListState> {
  SearchPinsListBloc(this._pinsRepository);

  final PinsRepository _pinsRepository;

  @override
  SearchPinsListState get initialState => LoadingState();

  @override
  Stream<SearchPinsListState> mapEventToState(
      SearchPinsListEvent event) async* {
    if (event is LoadData) {
      yield LoadingState();
      try {
        final pins = await _pinsRepository.getPins(label: event.label);

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
