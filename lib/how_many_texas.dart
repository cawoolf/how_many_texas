
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_many_texas/cubit/app_cubit.dart';
import 'package:how_many_texas/cubit/app_state.dart';
import 'package:how_many_texas/data/model/search_result.dart';
import 'package:how_many_texas/ui/error_page.dart';
import 'package:how_many_texas/ui/home_page.dart';
import 'package:how_many_texas/ui/how_page.dart';
import 'package:how_many_texas/ui/loading_page.dart';
import 'package:how_many_texas/ui/money_page.dart';
import 'package:how_many_texas/ui/response_page.dart';
import 'package:how_many_texas/ui/welcome_page.dart';

class HowManyTexas extends StatelessWidget {
  const HowManyTexas({super.key});


  @override
  Widget build(BuildContext context) {

    late SearchResult searchResult;

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
          searchResult = state.searchResult;
          return ResponsePage(
              searchImage: searchResult.searchImage, searchResult: searchResult);
        }

        else if(state is HowPageState) {
          // For testing
          String objectDimensions = '''
            {
              "length": 22,
              "width": 22,
              "unit": "inches"
            }
            ''';

          final SearchResult searchResult = SearchResult(search: 'userInput', searchImage: Image.asset(''), objectDimensionsResult: objectDimensions, finalNumberResult: '99999999999', TTS_PATH: '');

          return HowPage(searchResult: searchResult);
        }

        else {
          return const Text('Other Error');
        }
      }));
  }



}