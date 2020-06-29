import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class BoardRequestModel extends Equatable {
  const BoardRequestModel({@required this.name});

  final String name;

  String toJson() {
    return jsonEncode({
      'name': name,
    });
  }

  @override
  List<Object> get props => [name];
}
