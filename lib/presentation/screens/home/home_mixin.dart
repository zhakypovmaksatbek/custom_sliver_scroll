import 'package:custom_sliver/presentation/screens/home/home_page.dart';
import 'package:custom_sliver/src/sliver_scroll_controller.dart';
import 'package:flutter/material.dart';

mixin HomeMixin on State<HomePage> {
  final SliverScrollController bloc = SliverScrollController();
}
