import 'package:flutter/material.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/values/app_colors.dart';

class SubmitValue {
  String email;
  String password;

  SubmitValue({this.email, this.password});
}

class LoginWidget extends StatelessWidget {
  final _buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  );

  final double _buttonWidth = 350.0;
  final TextStyle _buttonTextStyle = TextStyle(color: AppColors.white);
  final TextStyle _boldTextStyle =
      TextStyle(color: AppColors.black, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "ログイン",
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildLoginAccountButton(context),
            Center(
              child: Text(
                "または",
                style: _boldTextStyle,
              ),
            ),
            _buildLoginForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginAccountButton(BuildContext context) {
    return Column(
      children: [
        Container(
          width: _buttonWidth,
          child: RaisedButton(
            color: AppColors.facebookButtonColor,
            shape: _buttonShape,
            child: Text(
              "Facebookで続行",
              style: _buttonTextStyle,
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoute.home, (_) => false);
            },
          ),
        ),
        Container(
          width: _buttonWidth,
          child: RaisedButton(
            color: AppColors.googleButtonColor,
            shape: _buttonShape,
            child: Text(
              "Googleで続行",
              style: _buttonTextStyle,
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoute.home, (_) => false);
            },
          ),
        ),
        Container(
          width: _buttonWidth,
          child: RaisedButton(
            color: AppColors.black,
            shape: _buttonShape,
            child: Text(
              "Appleで続行",
              style: _buttonTextStyle,
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoute.home, (_) => false);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Container(
      width: _buttonWidth,
      child: RaisedButton(
        color: AppColors.grey,
        shape: _buttonShape,
        child: Text(
          "ログイン",
          style: TextStyle(color: AppColors.darkGrey),
        ),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoute.home, (_) => false);
        },
      ),
    ); //TODO あとでformつくる
  }
}
