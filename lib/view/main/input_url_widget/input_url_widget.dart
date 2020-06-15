import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/view/main/crawling_image/crawling_image_widget.dart';
import 'package:pintersest_clone/view/web/my_in_app_browser.dart';

class InputUrlWidget extends StatefulWidget {
  final ChromeSafariBrowser browser = MyChromeSafariBrowser(MyInAppBrowser());

  @override
  _InputUrlState createState() => _InputUrlState();
}

class _InputUrlState extends State<InputUrlWidget> {
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUrlForm() {
    return Row(
      children: [
        Builder(builder: (context) {
          return Expanded(
            flex: 3,
            child: TextField(
              textInputAction: TextInputAction.done,
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Input Url",
              ),
              onSubmitted: (String text) {
                //TODO ここでブラウザを出すのはBonusで良いような気がしたので切り分ける
                Navigator.of(context).pushNamed(AppRoute.crawlingImage,
                    arguments: CrawlingImageArgs(url: text));
              },
            ),
          );
        }),
        Padding(
          padding: EdgeInsets.all(8),
        ),
        Expanded(
          flex: 1,
          child: RaisedButton(
            child: Text("cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
