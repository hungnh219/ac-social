import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/domain/entities/collection.dart';

import '../../../../domain/entities/post.dart';
import '../../../../utils/constants/image_path.dart';
import '../../../../utils/styles/themes.dart';
import 'collection_grid_view.dart';

class CollectionTab extends StatelessWidget {
  final List<CollectionModel> collections;

  const CollectionTab({super.key, required this.collections});

  SliverGridDelegateWithFixedCrossAxisCount get collectionDelegates => const SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2, // Adjust the number of columns as needed
  crossAxisSpacing: 10.0,
  mainAxisSpacing: 10.0,
  );

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: collectionDelegates,
      itemCount: collections.length,
      itemBuilder: (context, index) {
        final collection = collections[index];
        return Stack(
          alignment: Alignment.center,
          children: [

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: GridTile(
                child: Container(color: Colors.blue,),
                // child: ImagesGrid(posts: collection.posts),
              ),
            ),
            Center(
              child: Text(
                  collection.name,
                  style: AppTheme.gridItemStyle),
            ),
          ],
        );
      },
    );
  }
}

class ImagesGrid extends StatelessWidget {
  final List<PostModel> posts;

  const ImagesGrid({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return const Center(child: Text("No images available"));
    } else if (posts.length == 1) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            posts[0].image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black54,
            child: Text(
              posts[0].username,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    } else {
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(), // Prevent scrolling inside the tile
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Show 4 images max (2x2 grid)
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
        ),
        itemCount: posts.length > 4 ? 4 : posts.length,
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                posts[index].image,
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black54, // Optional: semi-transparent background for readability
                child: Text(
                  posts[index].username,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
      );
    }
  }
}