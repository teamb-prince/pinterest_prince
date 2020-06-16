import 'package:flutter/material.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/values/app_colors.dart';

class LoginTopWidget extends StatelessWidget {
  double _sizedBoxHeight = 40.0;
  final double _buttonWidth = 350.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(),
          SizedBox(
            height: _sizedBoxHeight,
          ),
          const Text(
            "Pinterestへようこそ！",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: _sizedBoxHeight,
          ),
          _buildCreateAccountButton(context),
          _buildLoginButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Image.asset("assets/images/login_image.png");
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return Container(
      width: _buttonWidth,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          "アカウントを無料登録",
          style: TextStyle(color: AppColors.white),
        ),
        color: AppColors.red,
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.createAccount);
        },
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return FlatButton(
      child: Text(
        "ログイン",
        style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pushNamed(context, AppRoute.login);
      },
    );
  }
}
