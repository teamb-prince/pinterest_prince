import 'package:flutter/material.dart';
import 'package:pintersest_clone/model/user_model.dart';

class UserDetailWidgetArguments {
  UserDetailWidgetArguments(this.user);

  final UserModel user;
}

class UserDetailWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as UserDetailWidgetArguments;
    return Scaffold(
      body: Container(),
    );
  }
}
