import 'package:hive/hive.dart';

part 'image_hive.g.dart';

@HiveType(typeId: 0)
class ImageDao extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String downloadUrl;

  ImageDao(this.id, this.downloadUrl);
}
