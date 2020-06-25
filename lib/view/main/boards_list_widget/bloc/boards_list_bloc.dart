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
    if (event is LoadData) {
      yield LoadingState();
      try {
        final boards = await _boardsRepository.getBoards();
        if (boards.isEmpty) {
          yield NoDataState();
        } else {
          final pins = <String, List<PinModel>>{};
          for (var i = 0; i < boards.length; i++) {
            pins[boards[i].id] = await _pinsRepository.getPins(
                boardId: boards[i].id, limit: 3);
          }
          yield LoadedDataState(boards, pins);
        }
      } on Exception catch (e) {
        yield ErrorState(e);
      }
    }
  }
}
