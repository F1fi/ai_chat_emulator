import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarContainer extends StatelessWidget {
  const AvatarContainer({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      height: 40,
      width: 40,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
    );

    return Container(
      height: 40,
      width: 40,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
      child: CachedNetworkImage(
        imageUrl: url,
        imageBuilder:
            (context, imageProvider) => Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.red,
                    BlendMode.colorBurn,
                  ),
                ),
              ),
            ),
        placeholder: (context, url) => placeholder,
        errorWidget: (context, _, __) => placeholder,
      ),
    );
  }
}
