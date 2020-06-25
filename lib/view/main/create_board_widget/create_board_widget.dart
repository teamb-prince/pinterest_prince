import 'package:flutter/material.dart';
import 'package:pintersest_clone/values/app_colors.dart';

class CreateBoardWidget extends StatefulWidget {
  @override
  _CreateBoardWidgetState createState() => _CreateBoardWidgetState();
}

class _CreateBoardWidgetState extends State<CreateBoardWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新規ボードを作成',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black)),
        iconTheme: const IconThemeData(color: AppColors.black),
        brightness: Brightness.light,
        backgroundColor: AppColors.white,
        elevation: 0,
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: FlatButton(
              onPressed: () {},
              color: AppColors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Text('作成', style: TextStyle(color: AppColors.white)),
            ),
          )
        ],
      ),
      body: _buildScreen(context),
    );
  }
  
  Widget _buildScreen(BuildContext context) {
    return Container();
  }
}
