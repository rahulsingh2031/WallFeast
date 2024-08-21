import 'dart:convert';

import 'package:wallpaper_gallery/handlers/data_provider_hander.dart';
import 'package:wallpaper_gallery/modal/gallery_image.dart';

class ImageProviderHander {
  static Future<List<GalleryImage>?> getRandomGalleryPhotos(int count) async {
    try {
      print("Imafge");
      final response = await DataProviderHander.getRandomImages(count);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<GalleryImage> galleryImages = [];
        for (final photo in data) {
          galleryImages.add(GalleryImage(
              imageUrl: photo['urls']['regular'],
              authorName: photo["user"]["username"],
              imageName: photo["description"]));
        }
        return galleryImages;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<GalleryImage>?> fetchGalleryImagesFromSearchQuery(
      String query, int count) async {
    try {
      final response =
          await DataProviderHander.fetchSearchRespone(query, count);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<GalleryImage> galleryImages = [];
        for (final photo in data['results']) {
          final description = photo["description"];
          galleryImages.add(
            GalleryImage(
              imageUrl: photo['urls']['regular'] as String,
              authorName: photo["user"]["username"] as String,
              imageName: photo["description"] is String ? description : null,
            ),
          );
        }
        return galleryImages;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
