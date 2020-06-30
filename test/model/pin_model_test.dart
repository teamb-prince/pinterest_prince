import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/values/assets.dart';

const PinModel expected = PinModel(
  id: 'ab917ee9-bf28-41ff-b914-550728159fae',
  userId: 'mrypq',
  url: 'https://automaton-media.com/articles/newsjp/20190501-91106/',
  title: '『LoL』少年アニメをテーマとしたスキンシリーズ「バトルアカデミア」がパッチ9.10で登場',
  imageUrl:
      'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/20190501-91106-001.jpg',
  description: 'かわいい！！！！！！！！！！！！！',
  uploadType: 'url',
  label: '',
  createdAt: '2020-01-02T10:10:10Z',
);

void main() {
  setUp(() {
    if (Directory.current.path.endsWith('/test')) {
      Directory.current = Directory.current.parent;
    }
  });

  test('decode json to images', () {
    final json = File(Assets.testPinResponse).readAsStringSync();
    final result = (jsonDecode(json) as List)
        .map((pin) => PinModel.fromJson(pin))
        .toList();

    expect(result[0].id, expected.id);
    expect(result[0].userId, expected.userId);
    expect(result[0].url, expected.url);
    expect(result[0].title, expected.title);
    expect(result[0].imageUrl, expected.imageUrl);
    expect(result[0].description, expected.description);
    expect(result[0].uploadType, expected.uploadType);
    expect(result[0].label, expected.label);
    expect(result[0].createdAt, expected.createdAt);
  });
}
