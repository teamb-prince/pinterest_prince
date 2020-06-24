import 'package:flutter/material.dart';
import 'package:pintersest_clone/model/board_model.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';

class BoardTile extends StatelessWidget {
  const BoardTile({@required this.board, @required this.pins});

  final BoardModel board;
  final List<PinModel> pins;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: _buildPinsView(context),
        ),
        const SizedBox(height: 8),
        Expanded(
          flex: 1,
          child: _buildInfoLabels(context),
        ),
      ],
    ));
  }

  Widget _buildPinsView(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: (pins.isNotEmpty)
                    ? Image.network(
                        pins[0].imageUrl,
                        fit: BoxFit.cover,
                      )
                    : Container(color: AppColors.grey)),
            const SizedBox(width: 2),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: (pins.length >= 2)
                          ? Image.network(
                              pins[1].imageUrl,
                              fit: BoxFit.cover,
                            )
                          : Container(color: AppColors.grey)),
                  const SizedBox(height: 2),
                  Expanded(
                      flex: 1,
                      child: (pins.length >= 3)
                          ? Image.network(
                              pins[2].imageUrl,
                              fit: BoxFit.cover,
                            )
                          : Container(color: AppColors.grey)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoLabels(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(board.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left),
    );
  }
}
