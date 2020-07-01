import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/pins_repository.dart';

import 'bloc.dart';

class BoardDetailBloc extends Bloc<BoardDetailEvent, BoardDetailState> {
  BoardDetailBloc(this._pinsRepository);

  final PinsRepository _pinsRepository;

  @override
  BoardDetailState get initialState => LoadingState();

  @override
  Stream<BoardDetailState> mapEventToState(BoardDetailEvent event) async* {
    if (event is LoadPins) {
      yield* _mapLoadBoardsToState(event);
    }
  }

  Stream<BoardDetailState> _mapLoadBoardsToState(LoadPins loadPins) async* {
    yield LoadingState();
    try {
      final pins = await _pinsRepository.getPins(boardId: loadPins.boardId);
      if (pins.isEmpty) {
        yield NoPinsState();
      }
      yield LoadedState(pins);
    } on Exception catch (e) {
      yield ErrorState(e);
    }
  }
}
