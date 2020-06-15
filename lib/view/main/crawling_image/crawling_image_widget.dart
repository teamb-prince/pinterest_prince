import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pintersest_clone/data/image_repository.dart';
import 'package:pintersest_clone/view/main/crawling_image/bloc/crawling_image_event.dart';
import 'package:pintersest_clone/view/main/crawling_image/bloc/crawling_image_state.dart';
import 'package:pintersest_clone/view/web/my_in_app_browser.dart';

import 'bloc/crawling_image_bloc.dart';

class CrawlingImageWidget extends StatefulWidget {
  final ChromeSafariBrowser browser = MyChromeSafariBrowser(MyInAppBrowser());

  @override
  _CrawlingImageState createState() => _CrawlingImageState();
}

class _CrawlingImageState extends State<CrawlingImageWidget> {
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
    return BlocProvider<CrawlingImageBloc>(
      create: (context) =>
          CrawlingImageBloc(context.repository<ImageRepository>()),
      child: Scaffold(
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
        Builder(builder: (context) {
          return Expanded(
            flex: 1,
            child: RaisedButton(
              child: Text("submit"),
              onPressed: () {
                BlocProvider.of<CrawlingImageBloc>(context)
                    .add(RequestSearch(_controller.text));
              },
            ),
          );
        })
      ],
    );
  }

  Widget _buildGetImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<CrawlingImageBloc, CrawlingImageState>(
          builder: (context, state) {
        if (state is LoadedState) {
          final List<String> imageUrls = state.imageModel.imageUrls;
          return GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: List.generate(imageUrls.length, (index) {
              return GestureDetector(
                onTap: () {
                  widget.browser.open(url: _controller.text);
                },
                child: Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover,
                ),
              );
            }),
          );
        } else if (state is NoImageState) {
          return Text("No image.");
        } else if (state is ErrorState) {
          return Text(state.exception.toString());
        } else if (state is LoadingState) {
          return CircularProgressIndicator();
        } else if (state is InitialState) {
          return Text("Initial state.");
        }
        return Container();
      }),
    );
  }
}
