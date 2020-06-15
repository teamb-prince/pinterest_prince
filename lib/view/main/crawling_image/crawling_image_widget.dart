import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintersest_clone/data/image_repository.dart';
import 'package:pintersest_clone/view/main/crawling_image/bloc/crawling_image_event.dart';
import 'package:pintersest_clone/view/main/crawling_image/bloc/crawling_image_state.dart';

import 'bloc/crawling_image_bloc.dart';

class CrawlingImageArgs {
  final String url;

  CrawlingImageArgs({@required this.url});
}

class CrawlingImageWidget extends StatefulWidget {
  @override
  _CrawlingImageState createState() => _CrawlingImageState();
}

class _CrawlingImageState extends State<CrawlingImageWidget> {
  @override
  Widget build(BuildContext context) {
    final CrawlingImageArgs args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<CrawlingImageBloc>(
      create: (context) =>
          CrawlingImageBloc(context.repository<ImageRepository>())
            ..add(RequestSearch(args.url)),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search Image"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                _buildGetImage(),
              ],
            ),
          ),
        ),
      ),
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
              return Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
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
