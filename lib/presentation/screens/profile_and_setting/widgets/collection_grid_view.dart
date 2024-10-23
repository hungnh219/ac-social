import 'package:flutter/material.dart';

class ImagesGrid extends StatelessWidget {
  final List<String> images;

  const ImagesGrid({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const Center(child: Text("No images available"));
    } else if (images.length == 1) {
      return Image.network(
        images[0],
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    } else {
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(), // Prevent scrolling inside the tile
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Show 4 images max (2x2 grid)
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
        ),
        itemCount: images.length > 4 ? 4 : images.length,
        itemBuilder: (context, index) {
          return Image.network(
            images[index],
            fit: BoxFit.cover,
          );
        },
      );
    }
  }
}