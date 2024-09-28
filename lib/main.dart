import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_many_texas/cubit/api_service.dart';
import 'package:how_many_texas/how_many_texas.dart';
import 'package:how_many_texas/purchase_test.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'cubit/app_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
      create: (context) => AppCubit(ApiService()),
      child: const HowManyTexas(),
      //   child: const PurchaseTest(),
    )
    );
  }
}

