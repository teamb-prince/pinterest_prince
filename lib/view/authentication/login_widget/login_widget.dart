import 'package:flutter/material.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/common_widget/base_button_widget.dart';

class SubmitValue {
  const SubmitValue({@required this.email, @required this.password});

  final String email;
  final String password;
}

class LoginWidget extends StatelessWidget {
  final _buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  );

  final double _buttonWidth = 350;
  final TextStyle _boldTextStyle =
      const TextStyle(color: AppColors.black, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'ログイン',
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
                'または',
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

  Widget _buildLoginForm(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Container(
      width: _buttonWidth,
      child: RaisedButton(
        color: AppColors.grey,
        shape: _buttonShape,
        child: const Text(
          'ログイン',
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
