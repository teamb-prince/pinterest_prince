import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/main/pin_detail_widget/pin_detail_widget.dart';
import 'package:pintersest_clone/app_route.dart';

class PinTile extends StatefulWidget {
  const PinTile({@required this.pin});

  final PinModel pin;

  @override
  _PinTileState createState() => _PinTileState();
}

class _PinTileState extends State<PinTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoute.pinDetail,
              arguments: PinDetailWidgetArguments(widget.pin));
        },
        child: Container(
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
        ));
  }
}
