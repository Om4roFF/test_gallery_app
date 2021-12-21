// import 'package:flutter/material.dart';
// import 'package:pagination_view/pagination_view.dart';
//
// class GridBody extends StatefulWidget {
//   const GridBody({Key? key}) : super(key: key);
//
//   @override
//   State<GridBody> createState() => _GridBodyState();
// }
//
// class _GridBodyState extends State<GridBody> {
//   int page = 1;
//   PaginationViewType paginationViewType = PaginationViewType.gridView;
//   GlobalKey<PaginationViewState> key = GlobalKey<PaginationViewState>();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PaginationView<String>(itemBuilder: (context, url, index){
//       return GridTile(
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const CircleAvatar(child: Icon(Icons.person)),
//             const SizedBox(height: 8),
//             Text(user.name),
//             const SizedBox(height: 8),
//             Text(user.email),
//           ],
//         ),
//       );
//     }, pageFetch: pageFetch, onEmpty: onEmpty, onError: onError)
//   }
// }
