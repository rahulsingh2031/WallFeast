import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wallpaper_gallery/modal/daily_gallery.dart';
import 'package:wallpaper_gallery/modal/gallery_image.dart';
import 'package:wallpaper_gallery/provider/daily_gallery_provider.dart';
import 'package:wallpaper_gallery/provider/download_gallery_provider.dart';
import 'package:wallpaper_gallery/screen/tab_screen.dart';
import 'package:wallpaper_gallery/utils/downloader_utils.dart';
import 'package:wallpaper_gallery/widgets/gallery_grid_viewer.dart';

class GalleryImageDetail extends ConsumerStatefulWidget {
  const GalleryImageDetail(
      {super.key,
      this.islocalImage = false,
      required this.image,
      this.imagePath = ""});
  final bool islocalImage;
  final String imagePath;
  final GalleryImage image;

  @override
  ConsumerState<GalleryImageDetail> createState() => _GalleryImageDetailState();
}

class _GalleryImageDetailState extends ConsumerState<GalleryImageDetail> {
  var currentFit = BoxFit.cover;
  @override
  Widget build(BuildContext context) {
    final dailyGallery = ref.watch<DailyGallery>(dailyGalleryProvider);
    final randomImages = dailyGallery.randomDailyImages;
    randomImages.shuffle();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (ctx) => const TabScreen()));
            },
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () async {
              await Clipboard.setData(
                  ClipboardData(text: widget.image.imageUrl));
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 1),
                    content: Text('Copied to your clipboard !')));
              }
              // copied successfully
            },
            icon: const Icon(Icons.copy),
          ),
          if (!widget.islocalImage)
            IconButton(
              onPressed: () async {
                final url = widget.image.imageUrl;
                var message = "Downloaded!";
                if (ref
                    .read(downloadGalleryProvider.notifier)
                    .checkIfImageExistOffline(url)) {
                  message = "Already downloaded,please check offline gallery";
                } else {
                  final imageFile =
                      await DownloaderUtils.getFileFromImageUrl(url);
                  await ref
                      .read(downloadGalleryProvider.notifier)
                      .addImageOffline(imageFile.path, widget.image);
                }
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 1),
                      content: Text(message),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.download),
            )
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                currentFit =
                    currentFit == BoxFit.cover ? BoxFit.contain : BoxFit.cover;
              });
            },
            child: widget.islocalImage
                ? Image.file(
                    File(widget.imagePath),
                    height: 300,
                    width: double.infinity,
                    fit: currentFit,
                  )
                : FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.image.imageUrl,
                    height: 300,
                    width: double.infinity,
                    fit: currentFit,
                  ),
          ),
          Text(
            "Tap image to toggle clipping",
            style: GoogleFonts.lato().copyWith(fontSize: 16),
          ),
          const Text("· · ─────── ·𖥸· ─────── · ·"),
          Text(
            widget.image.imageName ?? "Unknown Named",
            softWrap: true,
            overflow: TextOverflow.fade,
            style: GoogleFonts.lato().copyWith(fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Created by ${widget.image.authorName} and provided by Unsplash",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat().copyWith(fontSize: 12),
          ),
          const SizedBox(
            height: 24,
          ),
          if (!widget.islocalImage)
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "·Daily Photos·",
                      style: GoogleFonts.lato().copyWith(fontSize: 16),
                    ),
                    Expanded(
                      child: GalleryGridViewer(
                        imageList: randomImages,
                        galleyImageFit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
