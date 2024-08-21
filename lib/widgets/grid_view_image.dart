import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wallpaper_gallery/modal/gallery_image.dart';
import 'package:wallpaper_gallery/screen/gallery_image_detail.dart';

class GridViewImage extends StatelessWidget {
  const GridViewImage(
      {super.key, required this.galleryImage, this.fit = BoxFit.contain});
  final GalleryImage galleryImage;
  final BoxFit fit;

  void openImageDetailPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => GalleryImageDetail(image: galleryImage)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => openImageDetailPage(context),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: galleryImage.imageUrl,
          fit: fit,
        ),
      ),
    );
  }
}
