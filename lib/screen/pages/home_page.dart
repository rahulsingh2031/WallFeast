import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_gallery/enums/image_category.dart';
import 'package:wallpaper_gallery/modal/daily_gallery.dart';
import 'package:wallpaper_gallery/provider/daily_gallery_provider.dart';
import 'package:wallpaper_gallery/screen/category_screen.dart';
import 'package:wallpaper_gallery/screen/gallery_image_detail.dart';

import '../../widgets/carousel_image.dart';
import '../../widgets/gallery_grid_viewer.dart';

class HomePage extends ConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyGallery = ref.watch<DailyGallery>(dailyGalleryProvider);
    final randomImages = dailyGallery.randomDailyImages;
    randomImages.shuffle();

    return Column(
      children: [
        Text(
          "Curated for you",
          style: GoogleFonts.montserrat().copyWith(fontSize: 20),
        ),
        const Text("· · ─────── ·𖥸· ─────── · ·"),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          height: 200,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(6)),
          child: CarouselView(
            itemExtent: 300,
            shrinkExtent: 200,
            onTap: (value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => GalleryImageDetail(
                      image: dailyGallery.curatedImages[value]),
                ),
              );
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            children: [
              ...dailyGallery.curatedImages
                  .map((element) => CarouselImage(element)),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          "·Categories·",
          style: GoogleFonts.montserrat().copyWith(
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ImageCategory.values.length,
            itemBuilder: (content, index) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: SizedBox(
                width: 130,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.tertiary,
                        ]),
                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () => Navigator.push(
                        content,
                        MaterialPageRoute(
                          builder: (ctx) => CategoryScreen(
                              categoryName: ImageCategory.values[index].name),
                        ),
                      ),
                      child: Text(ImageCategory.values[index].name,
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          "·Daily Random Photos·",
          style: GoogleFonts.montserrat().copyWith(
            fontSize: 18,
          ),
        ),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                color: Theme.of(context).colorScheme.primaryFixed),
            child: GalleryGridViewer(
              imageList:
                  randomImages.length > 10 ? randomImages.sublist(0, 10) : [],
              galleyImageFit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}
