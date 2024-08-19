import 'package:custom_sliver/core/data/model/product_model.dart';
import 'package:custom_sliver/presentation/color/color_constants.dart';
import 'package:custom_sliver/presentation/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.height,
    this.isBonus = false,
  });
  final ProductModel product;
  final double? height;
  final bool? isBonus;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            product.photo ?? "",
            height: height ?? 130,
            width: height ?? 130,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                AppText(
                  title: product.name ?? "",
                  fontWeight: FontWeight.w600,
                  textType: TextType.header,
                ),
                AppText(
                  title: product.description ?? "",
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.darkGrey,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  textType: TextType.subtitle,
                ),
                Chip(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    backgroundColor: ColorConstants.lightGrey,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: ColorConstants.lightGrey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    label: AppText(
                      title: (product.productSizes?.length ?? 0) <= 1
                          ? "${product.minPrice ?? 0} som"
                          : "from ${product.minPrice ?? 0}",
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.black,
                      textType: TextType.body,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
