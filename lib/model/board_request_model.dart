import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class BoardRequestModel extends Equatable {
  const BoardRequestModel(
      {@required this.userId,
      @required this.name,
      @required this.topicId,
      @required this.description});

  final String userId;
  final String name;
  final String topicId;
  final String description;

  String toJson() {
    return jsonEncode({
      'user_id': userId,
      'name': name,
      'topic_id': topicId,
      'description': description,
    });
  }

  @override
  List<Object> get props => [userId, name, topicId, description];
}
