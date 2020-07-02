import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PinModel extends Equatable {
  const PinModel({
    @required this.id,
    @required this.userId,
    @required this.url,
    @required this.title,
    @required this.imageUrl,
    @required this.thumbImageUrl,
    @required this.uploadType,
    @required this.description,
    @required this.label,
    @required this.createdAt,
  });

  factory PinModel.fromJson(dynamic json) {
    return PinModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      url: json['url'] as String,
      title: json['title'] as String,
      imageUrl: json['image_url'] as String,
      thumbImageUrl: json['thumb_image_url'] as String,
      uploadType: json['upload_type'] as String,
      description: json['description'] as String,
      label: json['label'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  final String id;
  final String userId;
  final String url;
  final String title;
  final String imageUrl;
  final String thumbImageUrl;

  final String description;
  final String uploadType;
  final String label;
  final String createdAt;

  @override
  List<Object> get props => [
        id,
        userId,
        url,
        title,
        imageUrl,
        thumbImageUrl,
        uploadType,
        description,
        uploadType,
        label,
        createdAt,
      ];
}
