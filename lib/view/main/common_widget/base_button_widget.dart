import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pintersest_clone/values/app_colors.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    Key key,
    @required this.title,
    @required this.buttonColor,
    @required this.onPressedCallback,
  }) : super(key: key);

  double get _buttonWidth => 350;

  RoundedRectangleBorder get _buttonShape => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      );

  TextStyle get _buttonTextStyle => const TextStyle(color: AppColors.white);

  final String title;
  final Color buttonColor;
  final VoidCallback onPressedCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _buttonWidth,
      child: RaisedButton(
        color: buttonColor,
        shape: _buttonShape,
        child: Text(
          title,
          style: _buttonTextStyle,
        ),
        onPressed: onPressedCallback,
      ),
    );
  }
}

class RedButton extends BaseButton {
  const RedButton({
    Key key,
    @required String title,
    @required VoidCallback onPressedCallback,
  }) : super(
          key: key,
          title: title,
          onPressedCallback: onPressedCallback,
          buttonColor: AppColors.red,
        );
}

class FacebookButton extends BaseButton {
  const FacebookButton({
    Key key,
    @required String title,
    @required VoidCallback onPressedCallback,
  }) : super(
          key: key,
          title: title,
          onPressedCallback: onPressedCallback,
          buttonColor: AppColors.facebookButtonColor,
        );
}

class GoogleButton extends BaseButton {
  const GoogleButton({
    Key key,
    @required String title,
    @required VoidCallback onPressedCallback,
  }) : super(
          key: key,
          title: title,
          onPressedCallback: onPressedCallback,
          buttonColor: AppColors.googleButtonColor,
        );
}

class AppleButton extends BaseButton {
  const AppleButton({
    Key key,
    @required String title,
    @required VoidCallback onPressedCallback,
  }) : super(
          key: key,
          title: title,
          onPressedCallback: onPressedCallback,
          buttonColor: AppColors.black,
        );
}
