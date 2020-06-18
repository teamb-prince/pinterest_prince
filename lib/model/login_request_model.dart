import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class LoginRequestModel extends Equatable {
  final String email;
  final String password;

  const LoginRequestModel({@required this.email, @required this.password});

  String toJson() {
    return jsonEncode({
      'email': email,
      'password': password,
    });
  }

  @override
  List<Object> get props => [email, password];
}
