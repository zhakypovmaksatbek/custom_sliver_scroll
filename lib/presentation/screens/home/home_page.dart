// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:custom_sliver/core/data/model/product_model.dart';
import 'package:custom_sliver/presentation/bloc/bloc/product_bloc.dart';
import 'package:custom_sliver/presentation/color/color_constants.dart';
import 'package:custom_sliver/presentation/screens/home/home_mixin.dart';
import 'package:custom_sliver/presentation/screens/home/my_header_title.dart';
import 'package:custom_sliver/presentation/widgets/product_card.dart';
import 'package:custom_sliver/src/sliver_scroll_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomeMixin {
  @override
  void initState() {
    context.read<ProductBloc>().add(GetProduct());
    bloc.init();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoaded) {
              bloc.listCategory = state.products;

              return Scrollbar(
                controller: bloc.scrollControllerGlobally,
                radius: const Radius.circular(8),
                notificationPredicate: (notification) {
                  bloc.valueScroll.value = notification.metrics.extentInside;
                  return true;
                },
                child: ValueListenableBuilder(
                    valueListenable: bloc.globalOffsetValue,
                    builder: (_, valueCurrentScroll, __) {
                      return CustomScrollView(
                        controller: bloc.scrollControllerGlobally,
                        slivers: [
                          const SliverAppBar(
                            title: Text("Home Page"),
                          ),

                          const SliverToBoxAdapter(child: SizedBox(height: 15)),
                          SliverPersistentHeader(
                              pinned: true,
                              floating: true,
                              delegate: HeaderSliver(
                                  bloc: bloc, valueScroll: valueCurrentScroll)),
                          //Categories
                          // Categories and Products
                          for (var i = 0;
                              i < bloc.listCategory.length;
                              i++) ...[
                            SliverPersistentHeader(
                              delegate: MyHeaderTitle(
                                title: bloc.listCategory[i].name ??
                                    'Unknown Category',
                                onHeaderChange: (visible) => bloc.refreshHeader(
                                    i, visible,
                                    lastIndex: i > 0 ? i - 1 : null),
                              ),
                            ),
                            SliverPadding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final product =
                                        bloc.listCategory[i].products?[index];
                                    return ProductCard(
                                        product: product ?? ProductModel());
                                  },
                                  childCount:
                                      bloc.listCategory[i].products?.length ??
                                          0,
                                ),
                              ),
                            ),
                          ],
                        ],
                      );
                    }),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          },
        ),
      ),
    );
  }
}

const double _maxHeaderExtent = 60.0;

class HeaderSliver extends SliverPersistentHeaderDelegate {
  final SliverScrollController bloc;
  final double valueScroll;
  HeaderSliver({
    required this.bloc,
    required this.valueScroll,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final itemOffset = bloc.listOffsetHeader;

    // TODO: implement build
    return Container(
      color: ColorConstants.white,
      height: _maxHeaderExtent,
      child: SingleChildScrollView(
        controller: bloc.scrollControllerItemHeader,
        scrollDirection: Axis.horizontal,
        child: ValueListenableBuilder(
            valueListenable: bloc.headerNotifier,
            builder: (_, value, __) {
              return Row(
                  children: List.generate(bloc.listCategory.length, (index) {
                final category = bloc.listCategory[index];
                return GetBoxOffset(
                  offset: ((offset) {
                    if (index < itemOffset.length) {
                      itemOffset[index] = offset.dx;
                    }
                  }),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Chip(
                        backgroundColor:
                            index == value?.index ? ColorConstants.blue : null,
                        label: Text(category.name ?? 'Unknown Category')),
                  ),
                );
              }));
            }),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => _maxHeaderExtent;

  @override
  // TODO: implement minExtent
  double get minExtent => _maxHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}

class GetBoxOffset extends StatefulWidget {
  const GetBoxOffset({
    super.key,
    required this.offset,
    required this.child,
  });
  final Function(Offset offset) offset;
  final Widget child;
  @override
  State<GetBoxOffset> createState() => _GetBoxOffsetState();
}

class _GetBoxOffsetState extends State<GetBoxOffset> {
  GlobalKey widgetKey = GlobalKey();
  late Offset offset;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = widgetKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        offset = box.localToGlobal(Offset.zero);
        widget.offset(offset);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: widgetKey,
      child: widget.child,
    );
  }
}
