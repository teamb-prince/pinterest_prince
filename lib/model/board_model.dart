import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoardModel extends Equatable {
  const BoardModel({
    @required this.id,
    @required this.userId,
    @required this.name,
    @required this.topicId,
    @required this.description,
    @required this.createdAt,
  });

  factory BoardModel.fromJson(dynamic json) {
    return BoardModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      topicId: json['topic_id'] as String,
      description: json['description'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  final String id;
  final String userId;
  final String name;
  final String topicId;
  final String description;
  final String createdAt;

  @override
  List<Object> get props => [
        id,
        userId,
        name,
        topicId,
        description,
        createdAt,
      ];
}
