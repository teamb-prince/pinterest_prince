import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class SignUpRequestModel extends Equatable {
  const SignUpRequestModel(
      {@required this.email,
      @required this.password,
      @required this.confirmPassword});

  // 他にもいろいろ項目はあるのかも
  final String email;
  final String password;
  final String confirmPassword;

  String toJson() {
    return jsonEncode({
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
    });
  }

  @override
  List<Object> get props => [email, password, confirmPassword];
}
