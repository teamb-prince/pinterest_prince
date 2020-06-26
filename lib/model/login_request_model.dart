import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class LoginRequestModel extends Equatable {
  const LoginRequestModel({@required this.id, @required this.password});

  final String id;
  final String password;

  String toJson() {
    return jsonEncode({
      'id': id,
      'password': password,
    });
  }

  @override
  List<Object> get props => [id, password];
}
