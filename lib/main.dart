import 'package:custom_sliver/presentation/bloc/bloc/product_bloc.dart';
import 'package:custom_sliver/presentation/screens/content/content_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Custom Sliver App',
        home: MultiBlocProvider(providers: [
          BlocProvider(create: (context) => ProductBloc()),
        ], child: const ContentScreen()));
  }
}
