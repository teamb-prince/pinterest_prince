import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/users_repository.dart';
import 'package:pintersest_clone/view/main/pin_detail_widget/bloc/pin_detail_event.dart';
import 'package:pintersest_clone/view/main/pin_detail_widget/bloc/pin_detail_state.dart';

class PinDetailBloc extends Bloc<PinDetailEvent, PinDetailState> {
  PinDetailBloc(this._usersRepository);

  final UsersRepository _usersRepository;

  @override
  PinDetailState get initialState => LoadingState();

  @override
  Stream<PinDetailState> mapEventToState(PinDetailEvent event) async* {
    if (event is RequestUser) {
      yield LoadingState();
      try {
        final result = await _usersRepository.getUser(event.id);
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
