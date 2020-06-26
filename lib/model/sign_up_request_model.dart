import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SignUpRequestModel extends Equatable {
  const SignUpRequestModel(
      {@required this.id,
      @required this.email,
      @required this.password,
      @required this.confirmPassword});

  // 他にもいろいろ項目はあるのかも
  final String id;
  final String email;
  final String password;
  final String confirmPassword;

  String toJson() {
    return jsonEncode({
      'id': id,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
    });
  }

  @override
  List<Object> get props => [id, email, password, confirmPassword];
}
