import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/data/boards_repository.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/view/common/board_tile.dart';
import 'package:pintersest_clone/view/main/board_detail/board_detail_widget.dart';

import 'bloc/bloc.dart';

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
      if (state is LoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is NoDataState) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: <Widget>[
              _buildSearchBar(context),
            ],
          ),
        );
      }
      if (state is LoadedDataState) {
        final boards = state.boards;
        final pins = state.pins;
        return RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<BoardsListBloc>(context).add(LoadData());
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
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
                    crossAxisCount: 1, mainAxisSpacing: 16),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoute.boardDetail,
                          arguments: BoardDetailArgs(board: boards[index]));
                    },
                    child: BoardTile(
                        board: boards[index], pins: pins[boards[index].id]),
                  );
                }, childCount: boards.length),
              )
            ]),
          ),
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
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.createBoard).then((_) {
                BlocProvider.of<BoardsListBloc>(context).add(LoadData());
              });
            },
          ),
        ],
      ),
    );
  }
}
