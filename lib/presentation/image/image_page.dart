import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ImagePage extends StatelessWidget {
  final String path;

  const ImagePage({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _shareImage,
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Center(
        child: Image.file(
          File(path),
          fit: BoxFit.cover,
          width: double.infinity,
          // height: double.infinity,
        ),
      ),
    );
  }

  void _shareImage() async {
    await Share.shareFiles([path]);
  }
}
