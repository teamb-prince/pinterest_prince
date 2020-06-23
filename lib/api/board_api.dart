import 'dart:convert';

import 'package:pintersest_clone/api/api_client.dart';
import 'package:pintersest_clone/model/board_model.dart';

abstract class BoardsApi {
  Future<BoardModel> getBoard(String id);

  Future<List<BoardModel>> getBoards();
}

class DefaultBoardsApi extends BoardsApi {
  final ApiClient _apiClient;

  DefaultBoardsApi(this._apiClient);

  @override
  Future<BoardModel> getBoard(String id) async {
    final response = await _apiClient.get('/boards/$id');
    return BoardModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  @override
  Future<List<BoardModel>> getBoards() async {
    final response = await _apiClient.get('/boards');
    final list = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
        .map((board) => BoardModel.fromJson(board))
        .toList();
    return list;
  }
}
