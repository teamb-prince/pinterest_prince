import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/boards_repository.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/view/main/boards_list_widget/bloc/boards_list_event.dart';
import 'package:pintersest_clone/view/main/boards_list_widget/bloc/boards_list_state.dart';

class BoardsListBloc extends Bloc<BoardsListEvent, BoardsListState> {
  BoardsListBloc(this._boardsRepository, this._pinsRepository);

  final BoardsRepository _boardsRepository;
  final PinsRepository _pinsRepository;

  @override
  BoardsListState get initialState => LoadingState();

  @override
  Stream<BoardsListState> mapEventToState(BoardsListEvent event) async* {
    if (event is LoadBoards) {
      yield* _mapLoadBoardsToState(event);
    } else if (event is LoadPins) {

    }
  }

  Stream<BoardsListState> _mapLoadBoardsToState(LoadBoards loadBoards) async* {
    yield LoadingState();
    try {
      final boards = await _boardsRepository.getBoards();
      if (boards.isEmpty) {
        yield NoBoardsState();
      } else {
        yield LoadedBoardsState(boards);
      }
    } on Exception catch (e) {
      yield ErrorState(e);
    }
  }

  Stream<BoardsListState> _mapLoadPinsToState(LoadPins loadPins) async* {
    yield LoadingState();
    try {
      Map<String, List<PinModel>> pins;
      for (var i = 0; i < loadPins.boardIds.length; i++) {
        pins[loadPins.boardIds[i]] = await _pinsRepository.getPins();
      }
      yield LoadedPinsState(pins);
    } on Exception catch (e) {
      yield ErrorState(e);
    }
  }
}