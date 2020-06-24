import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/boards_repository.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/view/main/select_board_from_url_widget/bloc/select_board_from_url_event.dart';
import 'package:pintersest_clone/view/main/select_board_from_url_widget/bloc/select_board_from_url_state.dart';

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
        if (boards.isEmpty) {
          yield NoDataState();
        } else {
          yield LoadedState(boards);
        }
      } on Exception catch (e) {
        yield ErrorState(e);
      }
    }
  }
}
