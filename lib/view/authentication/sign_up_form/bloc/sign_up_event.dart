import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pintersest_clone/model/sign_up_request_model.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUp extends SignUpEvent {
  SignUp({@required this.signUpRequestModel});

  final SignUpRequestModel signUpRequestModel;

  @override
  List<Object> get props => [signUpRequestModel];
}
