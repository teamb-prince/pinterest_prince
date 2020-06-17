import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pintersest_clone/values/app_colors.dart';

// 今は仮のボードのリストです
List<String> boards = [
  'board 1',
  'board 2',
  'board 3',
];

class SelectBoardArguments {
  final File image;
  final String title;
  final String description;
  final String linkUrl;

  SelectBoardArguments(
      {@required this.image, this.title, this.description, this.linkUrl});
}

class SelectBoardWidget extends StatelessWidget {
  static const double _iconImageSize = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ボードを選択', style: TextStyle(color: AppColors.black)),
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.black),
        brightness: Brightness.light,
        elevation: 0,
      ),
      body: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) => index == boards.length
            ? _buildAddNewBoardButton()
            : _getChild(context, index),
        itemCount: boards.length + 1,
      ),
    );
  }

  Widget _getChild(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          SizedBox(
              height: _iconImageSize,
              width: _iconImageSize,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                    // 適当な画像です。
                    'https://d1fv7zhxzrl2y7.cloudfront.net/articlecontents/103160/dobai_AdobeStock_211353756.jpeg?1555031349',
                    fit: BoxFit.cover),
              )),
          const SizedBox(width: 16),
          Text(boards[index],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAddNewBoardButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: AppColors.red,
            child: Icon(Icons.add, color: AppColors.white),
          ),
          const SizedBox(width: 16),
          Text('新規ボードを作成',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
