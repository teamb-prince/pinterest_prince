import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/values/app_colors.dart';

import 'bloc/bloc.dart';

class PickupListWidget extends StatefulWidget {
  PickupListWidget({this.id});

  final int id;

  @override
  _PickupListWidgetState createState() => _PickupListWidgetState(id: id);
}

class _PickupListWidgetState extends State<PickupListWidget>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  _PickupListWidgetState({this.id});

  final int id;

  final List<String> description = ['満点の星空に癒される🌠', 'お城特集'];
  final List<String> title = ['星降る夜空に包まれたい', 'お城特集'];

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 240), vsync: this)
          ..addListener(() => setState(() {}));
    animation = Tween(begin: 0.0, end: -2000.0).animate(controller);
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PickupBloc>(
      create: (context) =>
          PickupBloc(context.repository<PinsRepository>())..add(LoadData(id)),
      child: BlocBuilder<PickupBloc, PickupState>(
        builder: (context, state) {
          if (state is LoadedState) {
            final pinsList = state.pins;
            return _buildPickupField(pinsList);
          } else if (state is ErrorState) {
            return Text(state.exception.toString());
          } else if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container(color: Colors.blue);
        },
      ),
    );
  }

  Widget _buildPickupField(List<PinModel> pins) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: <Widget>[
          _buildDescription(),
          _buildTitle(),
          Container(
            height: 280,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                children: pins
                    .map((pin) => _buildPinCard(pin.thumbImageUrl))
                    .toList()
                    .sublist(0, 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPinCard(String imageUrl) {
    return Transform.translate(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: Container(
          height: 300,
          width: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => Container(
                height: 100,
                color: AppColors.grey,
              ),
              errorWidget: (context, url, error) =>
                  Container(color: AppColors.grey),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      offset: Offset(animation.value, 0),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        child: Text(
          description[id - 1],
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      child: Text(
        title[id - 1],
        style: TextStyle(
          color: AppColors.black,
          fontSize: 27,
        ),
      ),
    );
  }
}
