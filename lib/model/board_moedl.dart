import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoardModel extends Equatable {
  const BoardModel({
    @required this.id,
    @required this.userId,
    @required this.originalUserId,
    @required this.url,
    @required this.title,
    @required this.imageUrl,
    @required this.boardId,
    @required this.description,
    @required this.createdAt,
  });

  factory BoardModel.fromJson(dynamic json) {
    return BoardModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      originalUserId: json['original_user_id'] as String,
      url: json['url'] as String,
      title: json['title'] as String,
      imageUrl: json['image_url'] as String,
      boardId: json['board_id'] as String,
      description: json['description'] as String,
      createdAt: json['created_at'] as DateTime,
    );
  }

  final String id;
  final String userId;
  final String originalUserId;
  final String url;
  final String title;
  final String imageUrl;
  final String boardId;
  final String description;
  final DateTime createdAt;

  @override
  List<Object> get props => [
        id,
        userId,
        originalUserId,
        url,
        title,
        imageUrl,
        boardId,
        description,
        createdAt,
      ];
}
