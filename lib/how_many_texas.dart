import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_many_texas/ui/ui_exports.dart';

class HowManyTexas extends StatelessWidget {
  const HowManyTexas({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, WorkingAppState>(
      builder: (BuildContext context, WorkingAppState state) {
        if (state is WelcomePageState) {
          return const WelcomePage();
        } else if (state is MoneyPageState) {
          return MoneyPage();
        } else if (state is HomePageState) {
          return const HomePage();
        } else if (state is APILoadingState) {
          return const LoadingPage();
        } else if (state is APIError) {
          return ErrorPage(error: state.errorMessage); // Error
        } else if (state is APILoaded) {
          return const ResponsePage();
        } else if (state is HowPageState) {
          return const HowPage();
        } else {
          return const Text('Other Error');
        }
      },
    );
  }
}

// To refactor navigation, use a BlocListener to push routes when listening for changes.
