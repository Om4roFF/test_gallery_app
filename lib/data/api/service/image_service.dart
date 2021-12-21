import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:test_app/data/api/model/image.dart';

class ImageService {
  static const BASE_URL = 'https://picsum.photos';

  Future<List<Image>> fetchImages() async {
    final response =
        await http.get(Uri.parse(BASE_URL + '/v2/list?page=1&limit=100'));
    if (response.statusCode == 200) {
      final List<dynamic> imageJson = json.decode(response.body);
      final List<Image> images =
          imageJson.map((json) => Image.fromJson(json)).toList();
      return images;
    }
    throw Exception('error image fetching');
  }

  Future<Uint8List?> downloadImage(String id) async {
    final response = await http.get(Uri.parse(BASE_URL + '/id/$id/600'));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
    return null;
  }
}
