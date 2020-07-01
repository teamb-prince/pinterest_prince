import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/boards_repository.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';

import 'bloc.dart';

class SelectBoardFromUrlBloc
    extends Bloc<SelectBoardFromUrlEvent, SelectBoardFromUrlState> {
  SelectBoardFromUrlBloc(this._boardsRepository, this._pinsRepository);

  final BoardsRepository _boardsRepository;
  final PinsRepository _pinsRepository;

  @override
  SelectBoardFromUrlState get initialState => LoadingState();

  @override
  Stream<SelectBoardFromUrlState> mapEventToState(
      SelectBoardFromUrlEvent event) async* {
    if (event is LoadData) {
      yield LoadingState();
      try {
        final boards = await _boardsRepository.getBoards();
        final pins = <String, List<PinModel>>{};
        for (var i = 0; i < boards.length; i++) {
          pins[boards[i].id] =
              await _pinsRepository.getPins(boardId: boards[i].id, limit: 1);
        }

        if (boards.isEmpty) {
          yield NoDataState();
        }
        yield LoadedState(boards, pins);
      } on Exception catch (e) {
        yield ErrorState(e);
      }
    } else if (event is SavePin) {
      yield LoadingState();
      try {
        await _pinsRepository.savePinFromUrl(event.pinRequestModel);
        yield SavedPinState();
      } on Exception catch (e) {
        yield ErrorState(e);
      }
    }
  }
}
