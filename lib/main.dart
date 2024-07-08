import 'package:add_to_cart/cubit/cart_cubit.dart';

import 'package:add_to_cart/cubit/favorite_cubit.dart';
import 'package:add_to_cart/cubit/filter_cubit.dart';
import 'package:add_to_cart/cubit/rating_cubit.dart';
import 'package:add_to_cart/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavoriteCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          create: (context) => RatingCubit(),
        ),
        BlocProvider(
          create: (context) => FilterCubit(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Add to cart',
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: const HomeScreen()),
    );
  }
}
