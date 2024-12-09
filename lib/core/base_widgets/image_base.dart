import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:shimmer/shimmer.dart';

enum ImageBaseType {
  SVG,
  IMAGE,
  NOTIMAGE,
}

enum ImageBaseUrlType {
  NETWORK,
  ASSET,
  FILE,
  ICON,
  IMAGE_CIRCLE,
}

// ignore: must_be_immutable
class ImageBase extends StatelessWidget {
  int? imageWidth;
  int? imageHeight;

  ImageBase(
    String this.urlImage, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.colorIconsSvg,
    this.urlImageError,
  }) : super(key: key);

  ImageBase.file(
    this.file, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.urlImageError,
  }) : super(key: key);

  ImageBase.icon(
    IconData this.icon, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color = ColorConstants.ICON,
    this.size,
    this.urlImageError,
  }) : super(key: key);

  String? urlImage;
  final double? width;
  final double? height;
  final BoxFit? fit;
  File? file;
  IconData? icon;
  Color? color;
  Color? colorIconsSvg;
  double? size;
  String? urlImageError;

  ImageBaseType checkImageType(String url) {
    if (StringValid.nullOrEmpty(url) &&
        StringValid.nullOrEmpty(file) &&
        StringValid.nullOrEmpty(icon)) {
      return ImageBaseType.NOTIMAGE;
    }
    if (url.endsWith(".svg")) {
      return ImageBaseType.SVG;
    }
    return ImageBaseType.IMAGE;
  }

  ImageBaseUrlType checkImageUrlType(String url) {
    if (StringValid.nullOrEmpty(url)) {
      if (icon != null) {
        return ImageBaseUrlType.ICON;
      }
      return ImageBaseUrlType.FILE;
    }
    if (url.startsWith('http') || url.startsWith('https')) {
      return ImageBaseUrlType.NETWORK;
    } else if (url.startsWith('assets/')) {
      return ImageBaseUrlType.ASSET;
    } else if (icon != null) {
      if (icon!.fontFamily
              .toString()
              .toLowerCase()
              .contains('CupertinoIcons'.toLowerCase()) ||
          icon!.fontFamily
              .toString()
              .toLowerCase()
              .contains('MaterialIcons'.toLowerCase())) {
        return ImageBaseUrlType.ICON;
      }
      return ImageBaseUrlType.FILE;
    }
    return ImageBaseUrlType.FILE;
  }

  Widget imageTypeWidget(
      String urlImage, ImageBaseType imageType, ImageBaseUrlType imageUrlType) {
    if (imageType == ImageBaseType.IMAGE) {
      if (imageUrlType == ImageBaseUrlType.NETWORK) {
        return CachedNetworkImage(
          imageUrl: urlImage,
          fadeOutDuration: Duration.zero,
          fadeInDuration: Duration.zero,
          width: width,
          height: height,
          imageBuilder: (context, imageProvider) {
            final ImageStream stream =
                imageProvider.resolve(const ImageConfiguration());
            stream.addListener(
              ImageStreamListener((ImageInfo info, _) {
                imageWidth = info.image.width;
                imageHeight = info.image.height;
              }),
            );

            return Container(
              width: imageWidth!.toDouble(),
              height: imageHeight!.toDouble(),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: imageProvider,
                    fit: fit,
                    filterQuality: FilterQuality.medium),
              ),
            );
          },
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: ColorConstants.NEUTRALS_6,
            highlightColor: Colors.grey.withOpacity(0.2),
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: ColorConstants.WHITE,
                borderRadius:
                    BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_2X),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Image.asset(
            urlImageError ?? ImagePathConstants.IMAGE_ERROR,
            width: 50,
            height: 50,
          ),
        );
      } else if (imageUrlType == ImageBaseUrlType.ASSET) {
        return Image.asset(
          urlImage,
          fit: fit,
          height: height,
          width: width,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(urlImageError ?? ImagePathConstants.IMAGE_ERROR);
          },
        );
      } else if (imageUrlType == ImageBaseUrlType.FILE) {
        return Image.file(
          file!,
          fit: fit,
          height: height,
          width: width,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(urlImageError ?? ImagePathConstants.IMAGE_ERROR);
          },
        );
      } else if (imageUrlType == ImageBaseUrlType.ICON) {
        return SizedBox(
          height: height,
          width: width,
          child: Icon(
            icon,
            color: color,
            size: size ?? DimensionsHelper.ONE_UNIT_SIZE * 45,
          ),
        );
      }
    }

    if (imageType == ImageBaseType.SVG) {
      if (imageUrlType == ImageBaseUrlType.NETWORK) {
        return SvgPicture.network(
          urlImage,
          fit: fit!,
          height: height,
          width: width,
          placeholderBuilder: (BuildContext context) => const SizedBox(
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ),
        );
      } else if (imageUrlType == ImageBaseUrlType.ASSET) {
        return SvgPicture.asset(
          urlImage,
          fit: fit!,
          height: height,
          width: width,
          color: colorIconsSvg,
          placeholderBuilder: (BuildContext context) => const SizedBox(
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ),
        );
      } else if (imageUrlType == ImageBaseUrlType.FILE) {
        return Expanded(
          child: SvgPicture.file(
            file!,
            fit: fit!,
            height: height,
            width: width,
            placeholderBuilder: (BuildContext context) => const SizedBox(
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            ),
          ),
        );
      } else if (imageUrlType == ImageBaseUrlType.ICON) {
        return SizedBox(
          height: height,
          width: width,
          child: Icon(
            icon,
            color: color,
          ),
        );
      }
    }

    if (imageType == ImageBaseType.NOTIMAGE) {
      return Image.asset(
        ImagePathConstants.LOGO_APP,
        fit: fit,
        height: height ?? DimensionsHelper.ONE_UNIT_SIZE * 50,
        width: width ?? DimensionsHelper.ONE_UNIT_SIZE * 50,
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final imageType = checkImageType(urlImage.toString());
    final imageUrlType = checkImageUrlType(urlImage.toString());
    return imageTypeWidget(
      urlImage.toString(),
      imageType,
      imageUrlType,
    );
  }
}
