import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_gallery/handlers/image_provider_hander.dart';
import 'package:wallpaper_gallery/modal/gallery_image.dart';
import 'package:wallpaper_gallery/widgets/gallery_grid_viewer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchTextController = TextEditingController();
  List<GalleryImage> images = [];
  bool isFetching = false;
  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchBar(
            controller: searchTextController,
            hintText: "  Search",
            keyboardType: TextInputType.name,
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            elevation: const WidgetStatePropertyAll(1),
            hintStyle: WidgetStatePropertyAll(GoogleFonts.poppins()),
            onSubmitted: (value) => fetchImages(value),
          ),
        ),
        Text(
          "Results",
          style: GoogleFonts.montserrat().copyWith(fontSize: 20),
        ),
        isFetching
            ? const Center(child: CircularProgressIndicator())
            : Expanded(
                child: GalleryGridViewer(
                imageList: images,
              ))
      ],
    );
  }
}
