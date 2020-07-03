import 'package:cached_network_image/cached_network_image.dart';
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
    final imageUrl1 = (pins.isNotEmpty) ? pins[0].imageUrl : '';
    final imageUrl2 = (pins.length >= 2) ? pins[1].imageUrl : '';
    final imageUrl3 = (pins.length >= 3) ? pins[2].imageUrl : '';

    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildLargeImage(imageUrl1),
            const SizedBox(width: 2),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  _buildSmallImage(imageUrl2),
                  const SizedBox(height: 2),
                  _buildSmallImage(imageUrl3),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLargeImage(String imageUrl) {
    return Expanded(flex: 2, child: _buildImage(imageUrl));
  }

  Widget _buildSmallImage(String imageUrl) {
    return Expanded(flex: 1, child: _buildImage(imageUrl));
  }

  Widget _buildImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.grey),
      )),
      errorWidget: (context, url, error) => Container(color: AppColors.grey),
      fit: BoxFit.cover,
    );
  }

  Widget _buildInfoLabels(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(board.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          textAlign: TextAlign.left),
    );
  }
}
