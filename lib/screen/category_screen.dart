// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_gallery/handlers/image_provider_hander.dart';

import 'package:wallpaper_gallery/modal/gallery_image.dart';
import 'package:wallpaper_gallery/widgets/gallery_grid_viewer.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    super.key,
    required this.categoryName,
  });
  final String categoryName;
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<GalleryImage> images = [];
  bool isFetching = false;
  Future<void> fetchImages(String query) async {
    setState(() {
      isFetching = true;
    });
    try {
      print("Fetching");
      images = (await ImageProviderHander.fetchGalleryImagesFromSearchQuery(
          query, 20))!;
      print("Fetched");
    } catch (e) {
      print("Fetching FAILED :   $e");
    }
    setState(() {
      isFetching = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchImages(widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Text(
            widget.categoryName,
            style: GoogleFonts.montserrat().copyWith(fontSize: 20),
          ),
          isFetching
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: GalleryGridViewer(
                  imageList: images,
                ))
        ],
      ),
    );
  }
}
