import 'package:flutter/material.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/values/assets.dart';
import 'package:pintersest_clone/view/common/base_button_widget.dart';

class LoginTopWidget extends StatelessWidget {
  final double _sizedBoxHeight = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(
              height: _sizedBoxHeight,
            ),
            const Text(
              'Pinterestへようこそ！',
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
      ),
    );
  }

  Widget _buildHeader() {
    return Image.asset(Assets.headerImage);
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return RedButton(
      title: 'アカウントを無料登録',
      key: const Key('signup_button'),
      onPressedCallback: () {
        Navigator.pushNamed(context, AppRoute.createAccount);
      },
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return FlatButton(
      key: const Key('login_button'),
      child: const Text(
        'ログイン',
        style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pushNamed(context, AppRoute.loginForm);
      },
    );
  }
}
