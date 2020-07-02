import 'package:flutter/material.dart';
import 'package:pintersest_clone/values/app_colors.dart';

class PickupCoverWidget extends StatefulWidget {
  @override
  _PickupCoverWidgetState createState() => _PickupCoverWidgetState();
}

class _PickupCoverWidgetState extends State<PickupCoverWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildField(context),
        _buildText(),
      ],
    );
  }

  Widget _buildField(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: <Widget>[
          Container(
            height: 500,
            width: size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.network(
                'https://bucket-pinterest-001.s3-ap-northeast-1.amazonaws.com/sample/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88+2020-07-02+17.09.20.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 500,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  AppColors.black.withOpacity(0.7),
                  AppColors.black.withOpacity(0.2),
                ],
                stops: const [
                  0.0,
                  1.0,
                ],
              ),
              borderRadius: BorderRadius.circular(32),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText() {
    return Center(
      child: Column(
        children: <Widget>[
          _buildDescription(),
          _buildTitle(),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        child: Text(
          '爆売れ中のコスメをチェック',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      child: Text(
        'オルチャンメイク特集❤️',
        style: TextStyle(
          color: AppColors.white,
          fontSize: 27,
        ),
      ),
    );
  }
}
