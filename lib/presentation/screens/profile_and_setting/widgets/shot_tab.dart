import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/image_path.dart';

class ShotTab extends StatelessWidget {
  final List<String> imageUrls;

  const ShotTab({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return Center(child: SvgPicture.asset(AppImages.empty));
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: StaggeredGridView.countBuilder(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrls[index],
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(
                    Icons.error), // Error widget if image fails to load
              ),
            );
          },
          staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0, // Horizontal space between items
        ),
      );
    }
  }
}