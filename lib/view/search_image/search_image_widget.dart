import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'serach_image_bloc.dart';

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
              BlocProvider.of<SearchImageBloc>(context)
                  .add(RequestSearch(_controller.text));
            },
          ),
        )
      ],
    );
  }

  Widget _buildGetImage() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SearchImageBloc, SearchImageState>(
            builder: (context, state) {
          if (state is LoadedState) {
            final List<String> imageUrls = state.imageModel.imageUrls;
            return GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              children: List.generate(imageUrls.length, (index) {
                return GestureDetector(
                  onTap: () {
                    print(imageUrls[index]);
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
