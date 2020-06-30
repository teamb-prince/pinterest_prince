import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/data/boards_repository.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/board_model.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/model/pin_request_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/main/select_board_from_url_widget/bloc/select_board_from_url_bloc.dart';
import 'package:pintersest_clone/view/main/select_board_from_url_widget/bloc/select_board_from_url_state.dart';

import 'bloc/select_board_from_url_event.dart';

class SelectBoardFromUrlArguments {
  SelectBoardFromUrlArguments(
      {@required this.imageUrl,
      @required this.url,
      @required this.title,
      @required this.description});

  final String url;
  final String imageUrl;
  final String title;
  final String description;
}

class SelectBoardFromUrlWidget extends StatelessWidget {
  static const double _iconImageSize = 40;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectBoardFromUrlBloc(
        RepositoryProvider.of<BoardsRepository>(context),
        RepositoryProvider.of<PinsRepository>(context),
      )..add(LoadData()),
      child: _buildScreen(context),
    );
  }

  Widget _buildScreen(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments
        as SelectBoardFromUrlArguments;

    return BlocConsumer<SelectBoardFromUrlBloc, SelectBoardFromUrlState>(
        listener: (context, state) {
      if (state is SavedPinState) {
        Navigator.popUntil(context, ModalRoute.withName(AppRoute.home));
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ボードを選択', style: TextStyle(color: AppColors.black)),
          backgroundColor: AppColors.white,
          iconTheme: const IconThemeData(color: AppColors.black),
          brightness: Brightness.light,
          elevation: 0,
        ),
        body: _buildBoardsListView(args),
      );
    });
  }

  Widget _buildBoardsListView(SelectBoardFromUrlArguments args) {
    return Builder(builder: (context) {
      return BlocBuilder<SelectBoardFromUrlBloc, SelectBoardFromUrlState>(
        builder: (context, state) {
          if (state is LoadedState) {
            final boards = state.boards;
            final pins = state.pins;
            return Container(
              child: ListView.builder(
                itemBuilder: (context, index) => index == boards.length
                    ? _buildAddNewBoardButton(context)
                    : _buildBoardTile(context, boards[index], pins, args),
                itemCount: boards.length + 1,
              ),
            );
          }
          return Container();
        },
      );
    });
  }

  Widget _buildBoardTile(BuildContext context, BoardModel board,
      Map<String, List<PinModel>> pins, SelectBoardFromUrlArguments args) {
    return BlocBuilder<SelectBoardFromUrlBloc, SelectBoardFromUrlState>(
        builder: (context, state) {
      final pinImageUrl =
          pins[board.id].isNotEmpty ? pins[board.id][0].imageUrl : null;
      return GestureDetector(
        onTap: () {
          final request = PinRequestModel(
            url: args.url,
            imageUrl: args.imageUrl,
            title: args.title,
            description: args.description,
            boardId: board.id,
          );
          BlocProvider.of<SelectBoardFromUrlBloc>(context)
              .add(SavePin(pinRequestModel: request));
        },
        child: _buildTile(board, pinImageUrl),
      );
    });
  }

  Widget _buildTile(BoardModel board, String pinImageUrl) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          SizedBox(
              height: _iconImageSize,
              width: _iconImageSize,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: pinImageUrl == null
                    ? Container(color: AppColors.grey)
                    : Image.network(pinImageUrl, fit: BoxFit.cover),
              )),
          const SizedBox(width: 16),
          Text(board.name,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAddNewBoardButton(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          await Navigator.of(context).pushNamed(AppRoute.createBoard);
          BlocProvider.of<SelectBoardFromUrlBloc>(context).add(LoadData());
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              const CircleAvatar(
                backgroundColor: AppColors.red,
                child: Icon(Icons.add, color: AppColors.white),
              ),
              const SizedBox(width: 16),
              const Text('新規ボードを作成',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ));
  }
}
