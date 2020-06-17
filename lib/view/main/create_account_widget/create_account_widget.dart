import 'package:flutter/material.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/main/common_widget/base_button_widget.dart';

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
              Navigator.pushNamed(context, AppRoute.login);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSelectAccountButton(BuildContext context) {
    return Column(
      children: [
        RedButton(
          title: "メールアドレスで続行",
          onPressedCallback: () {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoute.home, (_) => false);
          },
        ),
        FacebookButton(
          title: "Facebookで続行",
          onPressedCallback: () {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoute.home, (_) => false);
          },
        ),
        GoogleButton(
          title: "Googleで続行",
          onPressedCallback: () {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoute.home, (_) => false);
          },
        ),
        AppleButton(
          title: "Appleで続行",
          onPressedCallback: () {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoute.home, (_) => false);
          },
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Image.asset("assets/images/login_image.png");
  }
}
