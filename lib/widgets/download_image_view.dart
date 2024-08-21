import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_gallery/modal/download_image.dart';
import 'package:wallpaper_gallery/provider/download_gallery_provider.dart';
import 'package:wallpaper_gallery/screen/gallery_image_detail.dart';

class DownloadImageView extends ConsumerWidget {
  const DownloadImageView({
    super.key,
    required this.downlaodImage,
  });
  final DownlaodImage downlaodImage;

  void openImageDetailPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => GalleryImageDetail(
                  image: downlaodImage.galleryImage,
                  islocalImage: true,
                  imagePath: downlaodImage.imagePath,
                )));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => openImageDetailPage(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(downlaodImage.imagePath),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 75,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(8)),
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.6)),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Author : ${downlaodImage.galleryImage.authorName}",
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          style: GoogleFonts.lato().copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).colorScheme.onInverseSurface,
                        onPressed: () => ref
                            .read(downloadGalleryProvider.notifier)
                            .deleteImageOffline(downlaodImage),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}
