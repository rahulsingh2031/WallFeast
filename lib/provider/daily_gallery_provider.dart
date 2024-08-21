import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_gallery/handlers/image_provider_hander.dart';
import 'package:wallpaper_gallery/modal/daily_gallery.dart';
import 'package:wallpaper_gallery/modal/gallery_image.dart';

class DailyGalleryNotifier extends StateNotifier<DailyGallery> {
  bool hasInitialized = false;
  DailyGalleryNotifier()
      : super(
          DailyGallery(
            curatedImages: [],
            randomDailyImages: [],
            initializeDateTime: DateTime.now(),
          ),
        );
  late final Isar isar;
  Future<void> initializeOnLoad() async {
    if (hasInitialized) return;
    //Check if it is initialize already or not
    //if it is initialize ,check if it 24 hr gap or not
    //if initialize gap is 24 or more,reinitialize or fetch6
    //else just get gallery images from downloaded ones
    hasInitialized = true;
    isar = Isar.getInstance()!;
    final collection = await isar.dailyGallerys.where().findAll();

    //if App is opened first time or collection empty

    if (collection.isEmpty) {
      await isar.writeTxn(() async {
        print("hello");
        final newDailyGallery = await DailyGallery.getDailyGalley();

        final id = await isar.dailyGallerys.put(newDailyGallery);
        print(id);
        state = (await isar.dailyGallerys.get(id))!;
      });
      return;
    }
    final dailyGallery = collection[0];

    final timeDifference =
        dailyGallery.initializeDateTime.difference(DateTime.now());
    bool shouldFetch = timeDifference.inHours >= 12;

    if (shouldFetch) {
      await fetchDailyGallery(dailyGallery);
      deleteDailyGallery(dailyGallery);
    } else {
      state = dailyGallery;
    }
  }

  Future<DailyGallery> fetchDailyGallery(DailyGallery dailyGallery) async {
    late List<GalleryImage>? curatedImages;
    late List<GalleryImage>? randomDailyImages;
    late DateTime initializeTime;
    try {
      curatedImages = await ImageProviderHander.getRandomGalleryPhotos(
          Random().nextInt(2) + 3);
      randomDailyImages = await ImageProviderHander.getRandomGalleryPhotos(
          Random().nextInt(20) + 25);
      initializeTime = DateTime.now();
    } catch (e) {
      curatedImages = dailyGallery.curatedImages;
      randomDailyImages = dailyGallery.randomDailyImages;
      initializeTime = dailyGallery.initializeDateTime;
    }
    final newState = DailyGallery(
        curatedImages: curatedImages!,
        randomDailyImages: randomDailyImages!,
        initializeDateTime: initializeTime);

    state = newState;
    return newState;
  }

  void deleteDailyGallery(DailyGallery gallery) async {
    await isar.writeTxn(() async {
      final success = await isar.dailyGallerys.delete(gallery.id);
      print('Gallery  deleted: $success');
    });
  }
}

final dailyGalleryProvider =
    StateNotifierProvider<DailyGalleryNotifier, DailyGallery>(
        (ref) => DailyGalleryNotifier());
