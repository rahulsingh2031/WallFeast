import 'package:flutter/material.dart';
import 'package:wallpaper_gallery/modal/gallery_image.dart';

import 'grid_view_image.dart';

class GalleryGridViewer extends StatelessWidget {
  const GalleryGridViewer({
    super.key,
    this.padding = const EdgeInsets.only(top: 8, left: 8, right: 8),
    this.galleyImageFit = BoxFit.contain,
    required this.imageList,
  });
  final BoxFit galleyImageFit;
  final EdgeInsetsGeometry padding;
  final List<GalleryImage> imageList;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8),
      itemCount: imageList.length,
      itemBuilder: (ctx, index) {
        return GridViewImage(
          galleryImage: imageList[index],
          fit: galleyImageFit,
        );
      },
    );
  }
}
