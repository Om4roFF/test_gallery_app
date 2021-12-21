import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_app/data/api/model/image.dart';
import 'package:test_app/data/database/image_hive.dart';

import '../../dependencies.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc(GalleryState initialState) : super(initialState) {
    on<GalleryFetchImages>(
      (event, emit) async {
        try {
          if (!state.isBottom) {
            if (firstTime) {
              emit(state.copyWith(images: null));
              firstTime = false;
            } else {
              emit(state.copyWith(isBottom: true, images: imagePaths));
            }
            final box = Hive.box('image_box');
            Directory tempDir = await getTemporaryDirectory();
            if (images.isEmpty) {
              images = await ApiModule.imageService().fetchImages();
            }
            if (page * 20 < 100) {
              for (int i = index; i < page * 20; i++) {
                if (box.containsKey(images[i].id)) {
                  final path = box.get(images[i].id);
                  print(path);
                  imagePaths.add(path);
                } else {
                  print('index: $i, page: $page, id: ${images[i].id}');
                  final imageBytes = await ApiModule.imageService()
                      .downloadImage(images[i].id);
                  if (imageBytes != null) {
                    String savePath = tempDir.path + "/${images[i].id}.jpg";
                    File imgFile = File(savePath);
                    await imgFile.writeAsBytes(imageBytes);
                    print(savePath);
                    imagePaths.add(savePath);
                    box.put(images[i].id, savePath);
                  } else {
                    print('image is empty');
                    imagePaths.add('hello');
                  }
                }
              }
              index = page * 20;
              page += 1;
              emit(state.copyWith(images: imagePaths));
            } else {
              emit(state.copyWith(isEnd: true));
            }
          }
        } catch (_) {
          emit(state.copyWith(message: _.toString()));
        }
      },
    );
  }

  final List<String> imagePaths = <String>[];
  bool firstTime = true;
  List<Image> images = <Image>[];
  int page = 1;
  int index = 0;
}
