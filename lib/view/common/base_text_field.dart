import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  const BaseTextField(
      {@required this.title,
      @required this.hintText,
      @required this.textEditingController});

  final String title;
  final String hintText;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.left,
          ),
          TextField(
            controller: textEditingController,
            decoration:
                InputDecoration(border: InputBorder.none, hintText: hintText),
          ),
        ],
      ),
    );
  }
}
