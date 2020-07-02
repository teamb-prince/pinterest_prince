import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/api/errors/error.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'bloc.dart';

class PickupBloc extends Bloc<PickupEvent, PickupState> {
  final PinsRepository _pinsRepository;
  PickupBloc(this._pinsRepository);

  @override
  PickupState get initialState => LoadingState();

  @override
  Stream<PickupState> mapEventToState(PickupEvent event) async* {
    if (event is LoadData) {
      yield LoadingState();
      try {
        final result = await _pinsRepository.getPickup(id: event.id, limit: 10);
        if (result == null) {
          yield NoDataState();
        }
        yield LoadedState(result);
      } on Exception catch (e) {
        yield ErrorState(e);
      }
    }
  }
}
