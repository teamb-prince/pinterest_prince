import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pintersest_clone/app_route.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';
import 'package:pintersest_clone/view/main/pin_detail/pin_detail_widget.dart';

class PinTile extends StatelessWidget {
  const PinTile({@required this.pin});

  final PinModel pin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoute.pinDetail,
              arguments: PinDetailWidgetArguments(pin));
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: pin.imageUrl,
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
