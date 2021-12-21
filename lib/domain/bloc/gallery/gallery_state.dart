part of 'gallery_bloc.dart';

class GalleryState {
  final List<String>? images;
  final bool isBottom;
  final bool isEnd;
  final String? message;

  GalleryState(
      {this.images, this.isBottom = false, this.isEnd = false, this.message});

  GalleryState copyWith(
      {List<String>? images, bool? isBottom, bool? isEnd, String? message}) {
    return GalleryState(
        images: images ?? this.images,
        isBottom: isBottom ?? false,
        isEnd: isEnd ?? false,
        message: message);
  }
}
