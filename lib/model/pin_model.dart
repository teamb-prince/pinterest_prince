import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PinModel extends Equatable {
  final String id;
  final String url;
  final String title;
  final String imageUrl;
  final String board;
  final String description;

  PinModel({
    @required this.id,
    @required this.url,
    @required this.title,
    @required this.imageUrl,
    @required this.board,
    @required this.description,
  });

  factory PinModel.fromJson(dynamic json) {
    return PinModel(
      id: json['id'] as String,
      url: json['url'] as String,
      title: json['title'] as String,
      imageUrl: json['image_url'] as String,
      board: json['board'] as String,
      description: json['description'] as String,
    );
  }

  @override
  List<Object> get props => [
        id,
        url,
        title,
        imageUrl,
        board,
        description,
      ];
}
