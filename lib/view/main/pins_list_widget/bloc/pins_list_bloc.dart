import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/view/main/pins_list_widget/bloc/pins_list_event.dart';
import 'package:pintersest_clone/view/main/pins_list_widget/bloc/pins_list_state.dart';

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
        final pins = await _pinsRepository.getPins();
        yield LoadedState(pins);
      } on Exception catch (e) {
        yield ErrorState(e);
      }
    }
  }
}