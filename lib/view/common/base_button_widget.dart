import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pintersest_clone/values/app_colors.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    Key key,
    @required this.title,
    @required this.buttonColor,
    @required this.buttonTextColor,
    @required this.onPressedCallback,
    this.buttonWidth,
  }) : super(key: key);

  RoundedRectangleBorder get _buttonShape => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      );

  final String title;
  final Color buttonColor;
  final Color buttonTextColor;
  final VoidCallback onPressedCallback;
  final double buttonWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      child: RaisedButton(
        color: buttonColor,
        shape: _buttonShape,
        child: Text(
          title,
          style: TextStyle(color: buttonTextColor),
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
          buttonWidth: 350,
          buttonTextColor: AppColors.white,
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
          buttonWidth: 350,
          buttonTextColor: AppColors.white,
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
          buttonWidth: 350,
          buttonTextColor: AppColors.white,
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
          buttonWidth: 350,
          buttonTextColor: AppColors.white,
        );
}
