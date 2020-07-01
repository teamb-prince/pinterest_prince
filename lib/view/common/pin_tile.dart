import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/main/pin_detail/pin_detail_widget.dart';

class PinTile extends StatefulWidget {
  const PinTile({@required this.pin, @required this.heroTag});

  final PinModel pin;
  final String heroTag;

  @override
  _PinTileState createState() => _PinTileState();
}

class _PinTileState extends State<PinTile> {
  bool _hasPadding = false;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.heroTag,
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 50),
      padding: EdgeInsets.all(_hasPadding ? 4 : 0),
      child: GestureDetector(
          onTapDown: (downDetails) {
            setState(() {
              _hasPadding = true;
            });
          },
          onTap: () {
            setState(() {
              _hasPadding = false;
            });
            Navigator.push(
                context,
                PageRouteBuilder(
                  settings: RouteSettings(
                    name: AppRoute.pinDetail,
                    arguments: PinDetailWidgetArguments(
                        pin: widget.pin, heroTag: widget.heroTag),
                  ),
                  transitionDuration: const Duration(milliseconds: 400),
                  pageBuilder: (_, __, ___) => PinDetailWidget(),
                ));
          },
          onTapCancel: () {
            setState(() {
              _hasPadding = false;
            });
          },
          child: _buildImage(context)),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: widget.pin.imageUrl,
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.grey),
              )),
              errorWidget: (context, url, error) =>
                  Container(color: AppColors.grey),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
