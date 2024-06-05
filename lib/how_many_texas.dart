
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_many_texas/cubit/app_cubit.dart';
import 'package:how_many_texas/cubit/app_state.dart';
import 'package:how_many_texas/ui/home_page.dart';
import 'package:how_many_texas/ui/loading_page.dart';
import 'package:how_many_texas/ui/response_page.dart';
import 'package:how_many_texas/ui/welcome_page.dart';

class HowManyTexas extends StatelessWidget {
  const HowManyTexas({super.key});


  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      title: 'How Many Texas?',
      home: BlocBuilder<AppCubit,AppState>(
      builder: (BuildContext context, AppState state) {
       if(state is WelcomePageState) {
         return const WelcomePage();
        }
       else if (state is HomePageState) {
         return const HomePage();
       }
       else if (state is APILoadingState){
         return const LoadingPage();
       }
       else if (state is APILoaded) {
         return const ResponsePage();
       }
       else{
         return const Text('Error'); // Error
       }
      }));
  }

  void _welcomePageDelay(BuildContext context) {
    final appCubit = BlocProvider.of<AppCubit>(context);
    appCubit.welcomePageDelay();
  }
}