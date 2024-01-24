import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../app_assets/app_icons.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double? borderRadius;
  final BoxFit? fit;
  const ImageNetworkWidget({super.key, required this.imageUrl, required this.width, required this.height, this.borderRadius, this.fit});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: CachedNetworkImage(
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        imageUrl: imageUrl,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: ColoredBox(color: Colors.grey.shade200),
        ),
        errorWidget: (context, url, error) => ColoredBox(
          color: Colors.grey.shade200,
          child: Image.asset(AppIcons.iconImageError, color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
