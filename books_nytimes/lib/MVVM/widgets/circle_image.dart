import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String imageUrl;

  const CircleImage({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        imageBuilder: (context, imageProvider) {
          return Image(
            image: imageProvider,
            fit: BoxFit.fill,
          );
        },
        placeholder: (context, url) {
          return Center(child: CircularProgressIndicator());
        },
        errorWidget: (context, url, error) {
          return Image.asset(
            "assets/images/default_book.jpg",
            fit: BoxFit.fill,
          );
        });
  }
}
