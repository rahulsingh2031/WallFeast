import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_gallery/modal/download_image.dart';
import 'package:wallpaper_gallery/provider/download_gallery_provider.dart';

import '../../widgets/download_image_view.dart';

class SavePages extends ConsumerWidget {
  const SavePages({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadImageList =
        ref.watch<List<DownlaodImage>>(downloadGalleryProvider);
    print("SAVE PAGE LOADED");
    return Center(
      child: Column(
        children: [
          Text(
            "Offline Gallery",
            style: GoogleFonts.montserrat().copyWith(fontSize: 20),
          ),
          const Text("· · ─────── ·𖥸· ─────── · ·"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
              child: ListView.builder(
                  itemCount: downloadImageList.length,
                  itemBuilder: (ctx, index) => DownloadImageView(
                        downlaodImage: downloadImageList[index],
                      )),
            ),
          )
        ],
      ),
    );
  }
}
