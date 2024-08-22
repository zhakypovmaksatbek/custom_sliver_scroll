// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CashedImages extends StatelessWidget {
  const CashedImages({
    super.key,
    required this.imageUrl,
    this.localImage,
    this.width,
    this.height,
    this.fit,
    this.imageRadius,
  });
  final String imageUrl;
  final String? localImage;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double? imageRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(imageRadius ?? 10),
      child: imageUrl.isNotEmpty && imageUrl != ""
          ? CachedNetworkImage(
              fit: fit ?? BoxFit.cover,
              imageUrl: imageUrl,
              height: height,
              width: width,
              // placeholder: (context, url) => SizedBox(
              //   width: width,
              //   height: height,
              //   child: Center(
              //     child: LoadingAnimationWidget.flickr(
              //         size: 40,
              //         leftDotColor: ColorConstants.black,
              //         rightDotColor: ColorConstants.primary),
              //   ),
              // ),
              // errorWidget: (context, url, error) => Image.asset(
              //   localImage ?? AssetConstants.noImage.png,
              //   width: width,
              //   height: height,
              // ),
            )
          : Image.asset(
              localImage!,
              width: width,
              height: height,
            ),
    );
  }
}

class CustomImageWidget extends StatelessWidget {
  const CustomImageWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
  });
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: fit,
      height: height ?? 171,
      width: width ?? 151,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return SizedBox(
            height: height ?? 171,
            width: width ?? 151,
            child: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
      },
      errorBuilder: (context, error, stackTrace) => Image.asset(
        " AssetConstants.noImage.png",
        height: height ?? 171,
        fit: BoxFit.cover,
        width: width ?? 151,
      ),
    );
  }
}
