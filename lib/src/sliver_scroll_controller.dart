import 'package:custom_sliver/core/data/model/category_model.dart';
import 'package:flutter/material.dart';

class SliverScrollController {
  List<CategoryModel> listCategory = [];
  List<double> listOffsetHeader = <double>[];
  final headerNotifier = ValueNotifier<MyHeader?>(null);
  final globalOffsetValue = ValueNotifier<double>(0);
  final goingDown = ValueNotifier<bool>(false);
  final valueScroll = ValueNotifier<double>(0);

  late ScrollController scrollControllerItemHeader;
  late ScrollController scrollControllerGlobally;

  void init() {
    listOffsetHeader =
        List.generate(listCategory.length, (index) => index.toDouble());

    scrollControllerItemHeader = ScrollController();
    scrollControllerGlobally = ScrollController();

    scrollControllerGlobally.addListener(_listenToScrollChange);
  }

  void _listenToScrollChange() {
    globalOffsetValue.value = scrollControllerGlobally.offset;
  }

  void dispose() {
    scrollControllerItemHeader.dispose();
    scrollControllerGlobally.dispose();
  }

  void refreshHeader(int index, bool visible, {int? lastIndex}) {
    final headerValue = headerNotifier.value;
    final headerTitle = headerValue?.index ?? index;
    final headerVisible = headerValue?.visible ?? false;

    if (headerTitle != index || lastIndex != null || headerVisible) {
      Future.microtask(
        () {
          if (!visible && lastIndex != null) {
            headerNotifier.value = MyHeader(
              visible: true,
              index: lastIndex,
            );
          } else {
            headerNotifier.value = MyHeader(
              visible: visible,
              index: index,
            );
          }
        },
      );
    }
  }
}

class MyHeader {
  final int index;
  final bool visible;
  MyHeader({required this.index, required this.visible});
}
