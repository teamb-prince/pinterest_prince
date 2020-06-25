import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/boards_repository.dart';
import 'package:pintersest_clone/view/main/create_board_widget/bloc/create_board_event.dart';
import 'package:pintersest_clone/view/main/create_board_widget/bloc/create_board_state.dart';

class CreateBoardBloc extends Bloc<CreateBoardEvent, CreateBoardState> {
  CreateBoardBloc(this._boardsRepository);

  final BoardsRepository _boardsRepository;

  @override
  CreateBoardState get initialState => InitialState();

  @override
  Stream<CreateBoardState> mapEventToState(CreateBoardEvent event) async* {
    if (event is SaveBoard) {
      yield LoadingState();
      try {
        final _ = _boardsRepository.saveBoard(event.boardRequestModel);
        yield SuccessState();
      } on Exception catch (e) {
        yield ErrorState(e);
      }
    }
  }
}