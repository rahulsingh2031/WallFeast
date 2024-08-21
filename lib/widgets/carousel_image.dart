import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wallpaper_gallery/modal/gallery_image.dart';
import 'package:wallpaper_gallery/screen/gallery_image_detail.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage(
    this.galleryImage, {
    super.key,
  });
  final GalleryImage galleryImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: const BoxDecoration(),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: galleryImage.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
