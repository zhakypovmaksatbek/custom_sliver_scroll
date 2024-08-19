import 'package:custom_sliver/presentation/widgets/app_text.dart';
import 'package:flutter/material.dart';

const double headerTitle = 80;
typedef OnHeaderChange = void Function(bool visible);

class MyHeaderTitle extends SliverPersistentHeaderDelegate {
  final OnHeaderChange onHeaderChange;
  final String title;

  MyHeaderTitle({required this.onHeaderChange, required this.title});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (shrinkOffset > 0) {
      onHeaderChange(true);
    } else {
      onHeaderChange(false);
    }

    return Padding(
        padding: const EdgeInsets.only(left: 16),
        child: AppText(
          title: title,
          textType: TextType.header,
        ));
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => headerTitle;

  @override
  // TODO: implement minExtent
  double get minExtent => headerTitle;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
