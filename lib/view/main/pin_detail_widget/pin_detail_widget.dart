import 'package:flutter/material.dart';

class PinDetailWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                _buildImage(),
                _buildImageInformation(),
                _buildActionButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Image.network(
        "https://avatars2.githubusercontent.com/u/23512935?s=460&u=8f50efae6e531658b6a52e0e70381c26408d7843&v=4");
  }

  Widget _buildImageInformation() {
    return Container(
      child: Column(
        children: [
          const Text("ピンもと: aaaaa"),
          const Text("たいとるうううううううううううううううう"),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.account_circle),
          RaisedButton(
            child: const Text("アクセス"),
            onPressed: () {
              print("access tapped");
            },
          ),
          RaisedButton(
            child: const Text("保存"),
            onPressed: () {
              print("save tapped");
            },
          ),
          Icon(Icons.account_circle),
        ],
      ),
    );
  }
}
