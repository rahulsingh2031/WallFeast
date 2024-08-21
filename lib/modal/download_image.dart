// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar/isar.dart';

import 'package:wallpaper_gallery/modal/gallery_image.dart';

part 'download_image.g.dart';

@collection
class DownlaodImage {
  Id id = Isar.autoIncrement;
  String imagePath;

  String get imageUrl => galleryImage.imageUrl;
  GalleryImage galleryImage;
  DownlaodImage({
    required this.imagePath,
    required this.galleryImage,
  });

  DownlaodImage copyWith({
    Id? id,
    String? imagePath,
    GalleryImage? galleryImage,
  }) {
    return DownlaodImage(
      imagePath: imagePath ?? this.imagePath,
      galleryImage: galleryImage ?? this.galleryImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imagePath': imagePath,
      'galleryImage': galleryImage.toMap(),
    };
  }

  factory DownlaodImage.fromMap(Map<String, dynamic> map) {
    return DownlaodImage(
      imagePath: map['imagePath'] as String,
      galleryImage:
          GalleryImage.fromMap(map['galleryImage'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory DownlaodImage.fromJson(String source) =>
      DownlaodImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DownlaodImage(id: $id, imagePath: $imagePath, galleryImage: $galleryImage)';

  @override
  bool operator ==(covariant DownlaodImage other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.imagePath == imagePath &&
        other.galleryImage == galleryImage;
  }

  @override
  int get hashCode => id.hashCode ^ imagePath.hashCode ^ galleryImage.hashCode;
}
