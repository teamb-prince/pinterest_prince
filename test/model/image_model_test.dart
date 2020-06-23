import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:pintersest_clone/model/image_model.dart';
import 'package:pintersest_clone/values/assets.dart';

const ImageModel expected = ImageModel(
  url: 'https://github.com/mrypq',
  imageUrls: [
    'https://example.com/image1.png',
    'https://example.com/image2.png',
    'https://example.com/image3.png'
  ],
  title: 'title',
  description: 'description',
);

void main() {
  setUp(() {
    if (Directory.current.path.endsWith('/test')) {
      Directory.current = Directory.current.parent;
    }
  });

  test('decode json to images', () {
    final json = File(Assets.testImagesResponse).readAsStringSync();
    final result = ImageModel.fromJson(jsonDecode(json));

    expect(result.url, expected.url);
    expect(result.imageUrls, result.imageUrls);
    expect(result.title, expected.title);
    expect(result.description, expected.description);
  });
}
