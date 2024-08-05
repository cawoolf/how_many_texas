import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_many_texas/ui/ui_exports.dart';

class HowManyTexas extends StatelessWidget {
  const HowManyTexas({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'How Many Texas?',
      home: BlocBuilder<AppCubit,AppState>(
      builder: (BuildContext context, AppState state) {
        if (state is WelcomePageState) {
          return const WelcomePage();
        }
        else if(state is MoneyPageState) {
          return MoneyPage(credits: state.credits);
        }

        else if(state is HomePageState) {
          return HomePage();
        }

        else if (state is APILoadingState) {
          return const LoadingPage();
        }
        else if (state is APIError){
          return ErrorPage(error: state.errorMessage); // Error
        }
        else if (state is APILoaded) {

          return ResponsePage();
        }

        else if(state is HowPageState) {

          return HowPage();
        }

        else {
          return const Text('Other Error');
        }
      }));
  }



}