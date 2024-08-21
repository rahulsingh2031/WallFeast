// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:wallpaper_gallery/handlers/image_provider_hander.dart';

import 'package:wallpaper_gallery/modal/gallery_image.dart';
part 'daily_gallery.g.dart';

@collection
class DailyGallery {
  Id id = Isar.autoIncrement;

  List<GalleryImage> curatedImages; // 3-4;
  List<GalleryImage> randomDailyImages; // 30-40
  DateTime initializeDateTime;

  DailyGallery({
    required this.curatedImages,
    required this.randomDailyImages,
    required this.initializeDateTime,
  });

  DailyGallery copyWith({
    Id? id,
    List<GalleryImage>? curatedImages,
    List<GalleryImage>? randomDailyImages,
    DateTime? initializeDateTime,
  }) {
    return DailyGallery(
      curatedImages: curatedImages ?? this.curatedImages,
      randomDailyImages: randomDailyImages ?? this.randomDailyImages,
      initializeDateTime: initializeDateTime ?? this.initializeDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'curatedImages': curatedImages.map((x) => x.toMap()).toList(),
      'randomDailyImages': randomDailyImages.map((x) => x.toMap()).toList(),
      'initializeDateTime': initializeDateTime.millisecondsSinceEpoch,
    };
  }

  factory DailyGallery.fromMap(Map<String, dynamic> map) {
    return DailyGallery(
      curatedImages: List<GalleryImage>.from(
        (map['curatedImages'] as List<int>).map<GalleryImage>(
          (x) => GalleryImage.fromMap(x as Map<String, dynamic>),
        ),
      ),
      randomDailyImages: List<GalleryImage>.from(
        (map['randomDailyImages'] as List<int>).map<GalleryImage>(
          (x) => GalleryImage.fromMap(x as Map<String, dynamic>),
        ),
      ),
      initializeDateTime:
          DateTime.fromMillisecondsSinceEpoch(map['initializeDateTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyGallery.fromJson(String source) =>
      DailyGallery.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DailyGallery(id: $id, curatedImages: $curatedImages, randomDailyImages: $randomDailyImages, initializeDateTime: $initializeDateTime)';
  }

  @override
  bool operator ==(covariant DailyGallery other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        listEquals(other.curatedImages, curatedImages) &&
        listEquals(other.randomDailyImages, randomDailyImages) &&
        other.initializeDateTime == initializeDateTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        curatedImages.hashCode ^
        randomDailyImages.hashCode ^
        initializeDateTime.hashCode;
  }

  static Future<DailyGallery> getDailyGalley() async {
    try {
      final curatedImages = await ImageProviderHander.getRandomGalleryPhotos(
          Random().nextInt(2) + 3);
      final randomDailyImages =
          await ImageProviderHander.getRandomGalleryPhotos(
              Random().nextInt(20) + 25);
      final initializeTime = DateTime.now();
      print("MOBS");
      return DailyGallery(
          curatedImages: curatedImages!,
          randomDailyImages: randomDailyImages!,
          initializeDateTime: initializeTime);
    } catch (e) {
      rethrow;
    }
  }
}
