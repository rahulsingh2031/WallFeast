import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:wallpaper_gallery/confidential.dart';

abstract class DataProviderHander {
  static const _baseUrl = "https://api.unsplash.com/";

  static Future<Response> getRandomImages(int count) async {
    try {
      final uri = Uri.parse(
          "${_baseUrl}photos/random?count=$count&client_id=$UNSPLASH_ACCESS_KEY");
      final response = await http.get(uri);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> fetchSearchRespone(String query, int count) async {
    try {
      final uri = Uri.parse(
          "${_baseUrl}search/photos?query=$query&per_page=$count&client_id=$UNSPLASH_ACCESS_KEY");
      final response = await http.get(uri);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
