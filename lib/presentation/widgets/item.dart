import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final String name;
  final String imageUrl;

  const ItemWidget({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl, // 'https://picsum.photos/250?image=9'
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ],
    );
  }
}
