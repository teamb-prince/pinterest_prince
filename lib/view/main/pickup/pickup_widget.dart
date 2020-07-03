import 'package:flutter/material.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/common/base_button_widget.dart';

import 'pickup_cover_widget.dart';
import 'pickup_list_widget.dart';

class PickupWidget extends StatefulWidget {
  @override
  _PickupWidgetState createState() => _PickupWidgetState();
}

class _PickupWidgetState extends State<PickupWidget> {
  final _pickupListWidget1 = PickupListWidget(id: 1);
  final _pickupListWidget2 = PickupListWidget(id: 2);
  final _pickupCoverWidget1 = PickupCoverWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildDateText(),
              _buildTitleText(),
              _pickupListWidget1,
              _pickupCoverWidget1,
              _pickupListWidget2,
              _buildFooterText(),
              _buildBackHomeButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateText() {
    final now = DateTime.now();
    final year = now.year;
    final month = now.month;
    final day = now.day; // 2019-08-18
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        child: Text(
          '$year年$month月$day日',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Text(
          '毎日が楽しくなるアイデア',
          style: TextStyle(
            color: AppColors.darkGrey,
            fontSize: 35,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildFooterText() {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.check_circle,
              color: AppColors.white,
              size: 30,
            ),
            Text(
              '本日はここまでです！',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 15,
              ),
            ),
            Text(
              'また明日ログインして、もっとアイデアを見てみましょう',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackHomeButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: BaseButton(
        title: 'ホームフィードへ戻る',
        buttonColor: AppColors.darkGrey,
        buttonTextColor: AppColors.white,
        onPressedCallback: () => Navigator.pushNamed(context, AppRoute.home),
      ),
    );
  }
}
