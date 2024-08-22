import 'package:custom_sliver/core/data/model/category_model.dart';
import 'package:custom_sliver/presentation/bloc/bloc/product_bloc.dart';
import 'package:custom_sliver/presentation/color/color_constants.dart';
import 'package:custom_sliver/presentation/screens/content/widgets/category_tab_bar.widget.dart';
import 'package:custom_sliver/presentation/screens/content/widgets/list_group.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<CategoryModel> listCategory = [];
  final List<CustomCategoryModel> _tabInfoList = [];

  void _initTabList() {
    _tabInfoList.clear();
    for (int i = 0; i < listCategory.length; i++) {
      _tabInfoList.add(CustomCategoryModel(
          globalKey: GlobalKey(), categoryModel: listCategory[i]));
    }
    _tabController = TabController(length: _tabInfoList.length, vsync: this);
  }

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProduct());
  }

  @override
  void deactivate() {
    VisibilityDetectorController.instance.notifyNow();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Widget contentList() {
      return SingleChildScrollView(
        child: Column(
          children: List.generate(listCategory.length, (index) {
            var item = listCategory[index];

            return VisibilityDetector(
              key: _tabInfoList[index].globalKey!,
              onVisibilityChanged: (VisibilityInfo info) {
                double screenHeight = MediaQuery.of(context).size.height;
                double visibleAreaOnScreen =
                    info.visibleBounds.bottom - info.visibleBounds.top;

                if (info.visibleFraction > 0.5 ||
                    visibleAreaOnScreen > screenHeight * 0.5) {
                  _tabController.animateTo(index);
                }
              },
              child: ListGroup(
                label: item.name ?? "",
                data: item.products ?? [],
              ),
            );
          }),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoaded) {
              listCategory = state.products;
              _initTabList();
              return CustomScrollView(
                slivers: [
                  const SliverAppBar(
                    title: Text('Tab bar sync with scroll'),
                    expandedHeight: 160,
                  ),
                  SliverPersistentHeader(
                    delegate: _CategoryTabBarDelegate(
                      controller: _tabController,
                      data: _tabInfoList,
                    ),
                    pinned: true,
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverToBoxAdapter(
                      child: contentList(),
                    ),
                  )
                ],
              );
            } else if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else {
              return const Center(child: Text("No products available"));
            }
          },
        ),
      ),
    );
  }
}

class _CategoryTabBarDelegate extends SliverPersistentHeaderDelegate {
  _CategoryTabBarDelegate({
    required this.controller,
    required this.data,
  });

  final TabController controller;
  final List<CustomCategoryModel> data;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(
      child: Container(
        color: ColorConstants.white,
        child: CategoryTabBar(
          controller: controller,
          data: data,
          overlapsContent: shrinkOffset / maxExtent > 0,
        ),
      ),
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
