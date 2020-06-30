import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/boards_repository.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/view/main/select_board_from_local_widget/bloc/select_board_from_local_event.dart';
import 'package:pintersest_clone/view/main/select_board_from_local_widget/bloc/select_board_from_local_state.dart';

class SelectBoardFromLocalBloc
    extends Bloc<SelectBoardFromLocalEvent, SelectBoardFromLocalState> {
  SelectBoardFromLocalBloc(this._boardsRepository, this._pinsRepository);

  final BoardsRepository _boardsRepository;
  final PinsRepository _pinsRepository;

  @override
  SelectBoardFromLocalState get initialState => LoadingState();

  @override
  Stream<SelectBoardFromLocalState> mapEventToState(
      SelectBoardFromLocalEvent event) async* {
    if (event is LoadBoards) {
      yield* _mapLoadBoardsToState(event);
    } else if (event is SavePin) {
      yield* _mapSavePinToState(event);
    }
  }

  Stream<SelectBoardFromLocalState> _mapLoadBoardsToState(
      LoadBoards loadBoards) async* {
    yield LoadingState();
    try {
      final boards = await _boardsRepository.getBoards();
      final pins = <String, List<PinModel>>{};
      for (var i = 0; i < boards.length; i++) {
        pins[boards[i].id] =
            await _pinsRepository.getPins(boardId: boards[i].id, limit: 1);
      }

      if (boards.isEmpty) {
        yield NoBoardsState();
      }

      yield LoadedState(boards, pins);
    } on Exception catch (e) {
      yield ErrorState(e);
    }
  }

  Stream<SelectBoardFromLocalState> _mapSavePinToState(SavePin savePin) async* {
    yield LoadingState();
    try {
      final _ = await _pinsRepository.savePinFromLocal(
          savePin.image, savePin.pinRequestModel);
      yield SavedPinState();
    } on Exception catch (e) {
      yield ErrorState(e);
    }
  }
}
