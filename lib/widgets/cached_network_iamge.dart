import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({super.key, required this.url, this.radius, this.boxFit});
  final String url;
  final double? radius;
  final BoxFit? boxFit;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
        fit: boxFit ?? BoxFit.cover,
        imageUrl: url,
        placeholder: (context, url) {
          return Container(
            color: Colors.grey,
          );
        },
        errorWidget: (context, url, error) => Container(
          color: Colors.red[100],
        ),
      ),
    );
  }
}
