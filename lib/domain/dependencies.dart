import 'package:test_app/data/api/service/image_service.dart';

class ApiModule {
  static ImageService? _imageService;

  static ImageService imageService() {
    _imageService ??= ImageService();
    return _imageService!;
  }
}
