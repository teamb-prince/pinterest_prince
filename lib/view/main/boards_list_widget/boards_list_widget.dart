import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintersest_clone/data/boards_repository.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/board_model.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/view/main/boards_list_widget/bloc/boards_list_bloc.dart';
import 'package:pintersest_clone/view/main/boards_list_widget/bloc/boards_list_event.dart';
import 'package:pintersest_clone/view/main/boards_list_widget/bloc/boards_list_state.dart';

class BoardsListWidget extends StatefulWidget {
  @override
  _BoardsListWidgetState createState() => _BoardsListWidgetState();
}

class _BoardsListWidgetState extends State<BoardsListWidget> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BoardsListBloc>(
      create: (context) {
        return BoardsListBloc(context.repository<BoardsRepository>(),
            context.repository<PinsRepository>())
          ..add(LoadData());
      },
      child: _buildScrollView(context),
    );
  }

  Widget _buildScrollView(BuildContext context) {
    return BlocBuilder<BoardsListBloc, BoardsListState>(
        builder: (context, state) {
      if (state is LoadedDataState) {
        final boards = state.boards;
        final pins = state.pins;
        return Container(
          padding: const EdgeInsets.all(8),
          child: CustomScrollView(slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: <Widget>[
                    _buildSearchBar(context),
                  ],
                )
              ]),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                return _BoardTile(
                    board: boards[index], pins: pins[boards[index].id]);
              }, childCount: boards.length),
            )
          ]),
        );
      }
      return Container();
    });
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _searchTextController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                prefixIcon: Icon(
                  Icons.search,
                  size: 24,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[200],
                filled: true,
                hintText: '自分のボードを探す',
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _BoardTile extends StatelessWidget {
  const _BoardTile({@required this.board, @required this.pins});

  final BoardModel board;
  final List<PinModel> pins;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(pins[0].imageUrl),
    );
  }
}
