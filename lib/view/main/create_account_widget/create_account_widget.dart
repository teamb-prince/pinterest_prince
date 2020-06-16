import 'package:flutter/material.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/values/app_colors.dart';

class CreateAccountWidget extends StatelessWidget {
  final _buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  );

  final double _buttonWidth = 350.0;
  final TextStyle _buttonTextStyle = TextStyle(color: AppColors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          _buildHeader(),
          const Text("登録方法の選択"),
          _buildSelectAccountButton(context),
          FlatButton(
            child: Text(
              "アカウントをお持ちですか?ログインする",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.black),
            ),
            onPressed: () {
              print("go to login");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSelectAccountButton(BuildContext context) {
    return Column(
      children: [
        Container(
          width: _buttonWidth,
          child: RaisedButton(
            color: AppColors.red,
            shape: _buttonShape,
            child: Text(
              "メールアドレスで続行",
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

  Widget _buildHeader() {
    return Image.asset("assets/images/login_image.png");
  }
}
