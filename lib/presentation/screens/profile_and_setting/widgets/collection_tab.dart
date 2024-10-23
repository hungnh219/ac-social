import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/domain/entities/collection.dart';

import '../../../../utils/constants/image_path.dart';
import 'collection_grid_view.dart';

class CollectionTab extends StatelessWidget {
  final List<CollectionModel> collections;

  const CollectionTab({super.key, required this.collections});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Adjust the number of columns as needed
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: collections.length,
      itemBuilder: (context, index) {
        final collection = collections[index];
        return Stack(
          alignment: Alignment.center,
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.grey),
            //     borderRadius: BorderRadius.circular(10.0),
            //   ),
            //   child: GridTile(
            //     footer: Center(
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text(
            //           collection.name,
            //           style: const TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.white,
            //             backgroundColor: Colors.black54,
            //           ),
            //         ),
            //       ),
            //     ),
            //     child: ImagesGrid(images: collection.postIds),
            //   ),
            // ),
          ],
        );
      },
    );
  }
}