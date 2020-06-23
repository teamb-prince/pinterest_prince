import 'package:pintersest_clone/api/board_api.dart';
import 'package:pintersest_clone/model/board_model.dart';

class BoardsRepository {
  BoardsRepository(this._boardApi);

  final BoardsApi _boardApi;

  Future<BoardModel> getBoard(String id) => _boardApi.getBoard(id);

  Future<List<BoardModel>> getBoards() => _boardApi.getBoards();
}
