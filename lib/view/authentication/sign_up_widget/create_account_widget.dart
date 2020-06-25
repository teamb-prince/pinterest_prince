import 'package:flutter/material.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/values/assets.dart';
import 'package:pintersest_clone/view/common_widget/base_button_widget.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          _buildHeader(),
          const Text('登録方法の選択'),
          _buildSelectAccountButton(context),
          FlatButton(
            child: const Text(
              'アカウントをお持ちですか?ログインする',
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
          title: 'メールアドレスで続行',
          onPressedCallback: () {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoute.home, (_) => false);
          },
        ),
        FacebookButton(
          title: 'Facebookで続行',
          onPressedCallback: () {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoute.home, (_) => false);
          },
        ),
        GoogleButton(
          title: 'Googleで続行',
          onPressedCallback: () {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoute.home, (_) => false);
          },
        ),
        AppleButton(
          title: 'Appleで続行',
          onPressedCallback: () {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoute.home, (_) => false);
          },
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Image.asset(Assets.headerImage);
  }
}
