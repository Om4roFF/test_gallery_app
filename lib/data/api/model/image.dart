class Image {
  final String id;
  final String author;
  final int width;
  final int height;
  final String downloadUrl;

  Image({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.downloadUrl,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'],
      author: json['author'],
      width: json['width'],
      height: json['height'],
      downloadUrl: json['download_url'],
    );
  }
}
