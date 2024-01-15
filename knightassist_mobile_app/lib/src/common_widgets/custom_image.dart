import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    // TODO: Use [CachedNetworkImage] if the url points to a remote resource
    return Image.asset(imageUrl);
  }
}
