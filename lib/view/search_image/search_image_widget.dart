import 'package:flutter/material.dart';

class SearchImageWidget extends StatefulWidget {
  @override
  _SearchImageState createState() => _SearchImageState();
}

class _SearchImageState extends State<SearchImageWidget> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Image"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              _buildUrlForm(),
              _buildGetImage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUrlForm() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Input Url",
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
        ),
        Expanded(
          flex: 1,
          child: RaisedButton(
            child: Text("submit"),
            onPressed: () {
              print(_controller.text);
              //TODO ここでPOSTする
            },
          ),
        )
      ],
    );
  }

  Widget _buildGetImage() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 300,
          child: Image.network(
            "https://avatars2.githubusercontent.com/u/23512935?s=460&u=8f50efae6e531658b6a52e0e70381c26408d7843&v=4",
            fit: BoxFit.cover,
          ),
        ),
      );
}
