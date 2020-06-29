import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintersest_clone/data/boards_repository.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/board_model.dart';
import 'package:pintersest_clone/model/pin_request_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';

import 'package:pintersest_clone/app_route.dart';
import 'bloc/select_board_from_local_bloc.dart';
import 'bloc/select_board_from_local_event.dart';
import 'bloc/select_board_from_local_state.dart';

class SelectBoardFromLocalArguments {
  SelectBoardFromLocalArguments(
      {@required this.image, this.title, this.description, this.linkUrl});

  final File image;
  final String title;
  final String description;
  final String linkUrl;
}

class SelectBoardFromLocalWidget extends StatelessWidget {
  static const double _iconImageSize = 40;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectBoardFromLocalBloc(
        RepositoryProvider.of<BoardsRepository>(context),
        RepositoryProvider.of<PinsRepository>(context),
      )..add(LoadBoards()),
      child: _buildScreen(context),
    );
  }

  Widget _buildScreen(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments
        as SelectBoardFromLocalArguments;

    return BlocConsumer<SelectBoardFromLocalBloc, SelectBoardFromLocalState>(
      listener: (context, state) {
        if (state is SavedPinState) {
          Navigator.popUntil(context, ModalRoute.withName(AppRoute.home));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title:
                const Text('ボードを選択', style: TextStyle(color: AppColors.black)),
            backgroundColor: AppColors.white,
            iconTheme: const IconThemeData(color: AppColors.black),
            brightness: Brightness.light,
            elevation: 0,
          ),
          body: _buildBoardsListView(args),
        );
      },
    );
  }

  Widget _buildBoardsListView(SelectBoardFromLocalArguments args) {
    return Builder(builder: (context) {
      return BlocBuilder<SelectBoardFromLocalBloc, SelectBoardFromLocalState>(
        builder: (context, state) {
          if (state is LoadedState) {
            final boards = state.boards;

            return Container(
              child: ListView.builder(
                itemBuilder: (context, index) => index == boards.length
                    ? _buildAddNewBoardButton()
                    : _buildBoardTile(context, boards[index], args),
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
      SelectBoardFromLocalArguments args) {
    return BlocBuilder<SelectBoardFromLocalBloc, SelectBoardFromLocalState>(
        builder: (context, state) {
      return GestureDetector(
        onTap: () {
          final request = PinRequestModel(
            url: args.linkUrl,
            title: args.title,
            imageUrl: '',
            boardId: board.id,
            description: args.description,
          );
          BlocProvider.of<SelectBoardFromLocalBloc>(context)
              .add(SavePin(image: args.image, pinRequestModel: request));
        },
        child: _buildTile(board),
      );
    });
  }

  Widget _buildTile(BoardModel board) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          SizedBox(
              height: _iconImageSize,
              width: _iconImageSize,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                    // 適当な画像です。
                    'https://d1fv7zhxzrl2y7.cloudfront.net/articlecontents/103160/dobai_AdobeStock_211353756.jpeg?1555031349',
                    fit: BoxFit.cover),
              )),
          const SizedBox(width: 16),
          Text(board.name,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAddNewBoardButton() {
    return Container(
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
    );
  }
}
