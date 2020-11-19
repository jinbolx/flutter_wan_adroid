import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/config/resource_manager.dart';

enum ImageType {
  normal,
  random,
  assets,
}

class WrapperImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final ImageType imageType;

  WrapperImage(
      {@required this.url,
      @required this.width,
      @required this.height,
      this.fit = BoxFit.fill,
      this.imageType = ImageType.normal});

  @override
  Widget build(BuildContext context) {
    print('image: $imageUrl');
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      placeholder: (context, url) =>
          ImageHelper.placeHolder(width: width, height: height),
      errorWidget: (context, url, error) =>
          ImageHelper.eror(width: width, height: height),
      fit: fit,
    );
  }

  String get imageUrl {
    switch (imageType) {
      case ImageType.normal:
        return url;
      case ImageType.random:
        return ImageHelper.randomUrl(
            key: url, width: width.toInt(), height: height.toInt());
      case ImageType.assets:
        return ImageHelper.warpAssets(url);
    }
    return url;
  }
}
