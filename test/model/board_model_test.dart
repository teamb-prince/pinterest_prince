import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:pintersest_clone/model/board_model.dart';
import 'package:pintersest_clone/values/assets.dart';

final BoardModel expected = BoardModel(
    id: '0fa0f068-9fbd-4edb-9f7a-255408cb99e1',
    userId: 'mrypq',
    name: '100均お役立ちグッズ',
    topicId: 'f707f6c6-1490-41d2-b651-6b85f0563c3d',
    description: '100均で買えるお役立ち商品まとめ',
    createdAt: '2020-06-16T09:06:44.705738+09:00');

void main() {
  setUp(() {
    if (Directory.current.path.endsWith('/test')) {
      Directory.current = Directory.current.parent;
    }
  });

  test('decode json to board', () {
    final json = File(Assets.testBoardResponse).readAsStringSync();
    final result = (jsonDecode(json) as List)
        .map((board) => BoardModel.fromJson(board))
        .toList();

    expect(result[0].id, expected.id);
    expect(result[0].userId, expected.userId);
    expect(result[0].name, expected.name);
    expect(result[0].topicId, expected.topicId);
    expect(result[0].description, expected.description);
    expect(result[0].createdAt, expected.createdAt);
  });
}
