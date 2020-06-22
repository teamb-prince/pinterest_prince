import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:pintersest_clone/model/user_model.dart';
import 'package:pintersest_clone/values/assets.dart';

final UserModel expected = UserModel(
    id: 'mrypq',
    firstName: 'めろ子',
    lastName: 'めろ田',
    profileImageUrl: 'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/profile_image.jpeg',
    description: 'めろぴっぴです',
    location: 'めろ王国',
    web: 'https://github.com/mrypq',
    createdAt: '2020-01-01T10:10:10Z'
);

void main() {
  setUp(() {
    if (Directory.current.path.endsWith('/test')) {
      Directory.current = Directory.current.parent;
    }
  });

  test('decode json to user', () {

    final json = File(Assets.testUserResponse).readAsStringSync();
    final result = UserModel.fromJson(jsonDecode(json));

    expect(result.id, expected.id);
    expect(result.firstName, expected.firstName);
    expect(result.lastName, expected.lastName);
    expect(result.profileImageUrl, expected.profileImageUrl);
    expect(result.description, expected.description);
    expect(result.location, expected.location);
    expect(result.web, expected.web);
    expect(result.createdAt, expected.createdAt);
  });
}