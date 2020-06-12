import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pintersest_clone/api/api_client.dart';
import 'package:pintersest_clone/api/pins_api.dart';
import 'package:pintersest_clone/model/pin_model.dart';

class PinDetailWidget extends StatefulWidget {
  @override
  _PinDetailWidgetState createState() => _PinDetailWidgetState();
}

class _PinDetailWidgetState extends State<PinDetailWidget> {
  PinsApi _pinsApi = DefaultPinsApi(ApiClient(Client()));
  String url =
      "https://avatars2.githubusercontent.com/u/23512935?s=460&u=8f50efae6e531658b6a52e0e70381c26408d7843&v=4";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            child: FutureBuilder(
                future: _pinsApi.getPin("ab917ee9-bf28-41ff-b914-550728159fae"),
                builder:
                    (BuildContext context, AsyncSnapshot<PinModel> snapshot) {
                  print("snapshot $snapshot");
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        _buildImage(snapshot.data.imageUrl),
                        _buildImageInformation(snapshot.data.title,
                            snapshot.data.description, snapshot.data.url),
                        _buildActionButton(),
                      ],
                    );
                  } else {
                    return SafeArea(child: Text("No Data."));
                  }
                }),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return Image.network(imageUrl);
  }

  Widget _buildImageInformation(String title, String description, String url) {
    return Container(
      child: Column(
        children: [
          Text("ピンもと: $url"),
          Text(title),
          Text(description),
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
