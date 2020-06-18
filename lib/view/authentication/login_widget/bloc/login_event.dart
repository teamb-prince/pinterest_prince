import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/login_request_model.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Login extends LoginEvent {
  final LoginRequestModel loginRequestModel;

  Login({this.loginRequestModel});

  @override
  List<Object> get props => [loginRequestModel];
}