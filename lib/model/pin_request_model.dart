import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PinRequestModel extends Equatable {
  const PinRequestModel({
    @required this.url,
    @required this.title,
    @required this.imageUrl,
    @required this.boardId,
    @required this.description,
  });

  final String url;
  final String title;
  final String imageUrl;
  final String boardId;
  final String description;

  String toJson() {
    return jsonEncode({
      'url': url,
      'title': title,
      'image_url': imageUrl,
      'board_id': boardId,
      'description': description,
    });
  }

  @override
  List<Object> get props {
    return [url, imageUrl, boardId, description];
  }
}
