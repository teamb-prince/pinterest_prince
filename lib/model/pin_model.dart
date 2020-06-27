import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PinModel extends Equatable {
  const PinModel({
    @required this.id,
    @required this.userId,
    @required this.url,
    @required this.title,
    @required this.imageUrl,
    @required this.uploadType,
    @required this.description,
  });

  factory PinModel.fromJson(dynamic json) {
    return PinModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      url: json['url'] as String,
      title: json['title'] as String,
      imageUrl: json['image_url'] as String,
      uploadType: json['upload_type'] as String,
      description: json['description'] as String,
    );
  }

  final String id;
  final String userId;
  final String url;
  final String title;
  final String imageUrl;
  final String uploadType;
  final String description;

  @override
  List<Object> get props => [
        id,
        userId,
        url,
        title,
        imageUrl,
        uploadType,
        description,
      ];
}
