import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/boards_repository.dart';

import 'bloc.dart';

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
        await _boardsRepository.saveBoard(event.boardRequestModel);
        yield SuccessState();
      } on Exception catch (e) {
        yield ErrorState(e);
      }
    }
  }
}
