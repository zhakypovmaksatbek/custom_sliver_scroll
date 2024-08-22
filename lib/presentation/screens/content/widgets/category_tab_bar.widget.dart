import 'package:custom_sliver/core/data/model/category_model.dart';
import 'package:custom_sliver/presentation/color/color_constants.dart';
import 'package:custom_sliver/presentation/widgets/image/cashed_images.dart';
import 'package:flutter/material.dart';

class CategoryTabBar extends StatefulWidget {
  const CategoryTabBar({
    super.key,
    required this.controller,
    required this.data,
    required this.overlapsContent,
  });

  final TabController controller;
  final List<CustomCategoryModel> data;
  final bool overlapsContent;

  @override
  State<CategoryTabBar> createState() => _CategoryTabBarState();
}

class _CategoryTabBarState extends State<CategoryTabBar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => TabBar(
        controller: widget.controller,

        isScrollable: true,
        indicatorColor: Colors.transparent,
        // labelPadding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
        splashBorderRadius: BorderRadius.circular(8),
        indicatorWeight: 1,
        dividerColor: Colors.transparent,
        labelStyle: const TextStyle(
            color: ColorConstants.black, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(),
        onTap: (index) {
          GlobalKey globalKey = widget.data[index].globalKey!;
          Scrollable.ensureVisible(
            globalKey.currentContext!,
            duration: const Duration(milliseconds: 250),
          );
        },
        tabs: List.generate(widget.data.length, (index) {
          var item = widget.data[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CashedImages(
                  imageUrl: item.categoryModel?.image ?? "",
                  imageRadius: 12,
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 4),
                Text(
                  '${item.categoryModel?.name}',

                  // fontWeight:
                  //     value == categories.id ? FontWeight.w500 : null,
                  // color: value == categories.id
                  //     ? ColorConstants.black
                  //     : Colors.grey,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
