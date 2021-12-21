import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/domain/bloc/gallery/gallery_bloc.dart';
import 'package:test_app/presentation/image/image_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController scrollController;

  bool viewLoad = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    refresher();
  }

  void refresher() {
    final bloc = BlocProvider.of<GalleryBloc>(context);
    double offset = 0;
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange &&
          scrollController.offset > offset) {
        bloc.add(GalleryFetchImages());
      }
      print('offset: $offset, scroll: ${scrollController.offset}');
      offset = scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<GalleryBloc, GalleryState>(
        listener: (context, state) {
          if (state.message != null) {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Text(state.message!),
                  );
                });
          }
        },
        builder: (context, state) {
          if (state.images != null) {
            return Column(
              children: [
                Expanded(
                  flex: 7,
                  child: GridView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(4.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: state.images!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Image.file(
                          File(state.images![index]),
                          errorBuilder: (context, exception, stackTrace) {
                            return Image.asset('assets/images/placeholder.png');
                          },
                        ),
                        onTap: () =>
                            _navigateToPhotoPage(context, state.images![index]),
                      );
                    },
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  child: state.isBottom
                      ? const Expanded(
                          child: SizedBox(
                            height: 60,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        )
                      : state.isEnd
                          ? const SizedBox(
                              height: 60,
                              child: Center(
                                child: Text('End of story'),
                              ),
                            )
                          : const SizedBox(),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // bottomNavigationBar: viewLoad
      //     ? const Center(child: CircularProgressIndicator())
      //     : const SizedBox(),
    );
  }

  void _navigateToPhotoPage(BuildContext context, String path) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImagePage(
          path: path,
        ),
      ),
    );
  }
}
