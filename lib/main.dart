import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/domain/bloc/gallery/gallery_bloc.dart';
import 'package:test_app/presentation/home/home_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('image_box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (BuildContext context) => GalleryBloc(GalleryState())
          ..add(
            GalleryFetchImages(),
          ),
        child: const HomePage(),
      ),
    );
  }
}
