import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class LoginRequestModel extends Equatable {
  const LoginRequestModel({@required this.email, @required this.password});

  final String email;
  final String password;

  String toJson() {
    return jsonEncode({
      'email': email,
      'password': password,
    });
  }

  @override
  List<Object> get props => [email, password];
}
