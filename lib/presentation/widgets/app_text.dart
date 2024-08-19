//ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:custom_sliver/presentation/color/color_constants.dart';
import 'package:flutter/material.dart';

enum TextType { header, body, title, subtitle, description, title20, title26 }

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    this.fontWeight,
    required this.title,
    this.maxLines,
    this.color,
    this.overflow,
    this.textAlign,
    required this.textType,
    this.textDirection,
    this.decoration,
  });

  final FontWeight? fontWeight;
  final String title;
  final int? maxLines;
  final Color? color;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextType textType;
  final TextDirection? textDirection;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = getTextStyle(textType);

    if (fontWeight != null) {
      textStyle = textStyle.copyWith(fontWeight: fontWeight);
    }

    Color? textColor = color ?? textStyle.color;

    return Text(
      title,
      overflow: overflow,
      maxLines: maxLines,
      textDirection: textDirection,
      textAlign: textAlign ?? TextAlign.start,
      style: textStyle.copyWith(
          color: textColor,
          fontWeight: fontWeight,
          decoration: decoration,
          decorationColor: ColorConstants.darkGrey),
    );
  }

  TextStyle getTextStyle(TextType type) {
    switch (type) {
      case TextType.header:
        return const TextStyle(
          color: ColorConstants.black,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        );
      case TextType.body:
        return const TextStyle(
          color: ColorConstants.darkGrey,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        );
      case TextType.title:
        return const TextStyle(
            color: ColorConstants.black,
            fontWeight: FontWeight.w700,
            fontSize: 22);
      case TextType.title20:
        return const TextStyle(color: ColorConstants.black, fontSize: 20);
      case TextType.title26:
        return const TextStyle(color: ColorConstants.black, fontSize: 26);
      case TextType.subtitle:
        return const TextStyle(
            color: ColorConstants.black,
            fontWeight: FontWeight.w400,
            fontSize: 14);
      case TextType.description:
        return const TextStyle(
            color: ColorConstants.white,
            fontWeight: FontWeight.w400,
            fontSize: 12);
      default:
        return const TextStyle(color: Colors.black);
    }
  }
}
