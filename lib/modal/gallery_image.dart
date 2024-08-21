import 'dart:convert';

import 'package:isar/isar.dart';
part 'gallery_image.g.dart';

@embedded
class GalleryImage {
  String imageUrl;
  String authorName;
  String? imageName;

  GalleryImage({
    this.imageUrl =
        "https://cdn.pixabay.com/photo/2022/12/01/04/35/sunset-7628294_640.jpg",
    this.authorName = " No Image",
    this.imageName = "",
  });

  GalleryImage copyWith({
    String? imageUrl,
    String? authorName,
    String? imageName,
  }) {
    return GalleryImage(
      imageUrl: imageUrl ?? this.imageUrl,
      authorName: authorName ?? this.authorName,
      imageName: imageName ?? this.imageName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'authorName': authorName,
      'imageName': imageName,
    };
  }

  factory GalleryImage.fromMap(Map<String, dynamic> map) {
    return GalleryImage(
      imageUrl: map['imageUrl'] as String,
      authorName: map['authorName'] as String,
      imageName: map['imageName'] != null ? map['imageName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GalleryImage.fromJson(String source) =>
      GalleryImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'GalleryImage(imageUrl: $imageUrl, authorName: $authorName, imageName: $imageName)';

  @override
  bool operator ==(covariant GalleryImage other) {
    if (identical(this, other)) return true;

    return other.imageUrl == imageUrl &&
        other.authorName == authorName &&
        other.imageName == imageName;
  }

  @override
  int get hashCode =>
      imageUrl.hashCode ^ authorName.hashCode ^ imageName.hashCode;
}
