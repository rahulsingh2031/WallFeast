import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_gallery/modal/download_image.dart';
import 'package:wallpaper_gallery/modal/gallery_image.dart';

class DownloadGalleryNotifier extends StateNotifier<List<DownlaodImage>> {
  bool hasInitialized = false;

  DownloadGalleryNotifier() : super([]);

  late final Isar isar;
  Future<void> initializeOnLoad() async {
    if (hasInitialized) return;
    hasInitialized = true;

    isar = Isar.getInstance()!;

    state = await isar.downlaodImages.where().findAll();
  }

  Future<void> addImageOffline(String path, GalleryImage image) async {
    final downloadImage = DownlaodImage(imagePath: path, galleryImage: image);
    await isar.writeTxn(() async {
      await isar.downlaodImages.put(downloadImage); // insert & update
    });
    final newState = [...state, downloadImage];
    state = newState;
  }

  Future<void> deleteImageOffline(DownlaodImage downlaodImage) async {
    await isar.writeTxn(() async {
      await isar.downlaodImages.delete(downlaodImage.id); // insert & update
    });
    final newState = state;
    newState.remove(downlaodImage);
    state = [...newState];
  }

  bool checkIfImageExistOffline(String url) {
    for (final downlaodImage in state) {
      if (url == downlaodImage.imageUrl) return true;
    }
    return false;
  }
}

final downloadGalleryProvider =
    StateNotifierProvider<DownloadGalleryNotifier, List<DownlaodImage>>(
        (ref) => DownloadGalleryNotifier());
