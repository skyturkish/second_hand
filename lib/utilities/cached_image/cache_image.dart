import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShowCachedImageOrFromNetwork extends StatelessWidget {
  const ShowCachedImageOrFromNetwork({super.key, required this.networkUrl});
  final String networkUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: networkUrl,
    );
  }
}
