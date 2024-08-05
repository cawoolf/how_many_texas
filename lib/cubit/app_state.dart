import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';


// Needs to extends Equatable
@immutable
abstract class AppState extends Equatable{
  const AppState();
}

class WelcomePageState extends AppState {
  const WelcomePageState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class MoneyPageState extends AppState {
  final int credits;
  const MoneyPageState(this.credits);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class HomePageState extends AppState {
  const HomePageState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class APILoadingState extends AppState {
  const APILoadingState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class APILoaded extends AppState {

  const APILoaded();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class APIError extends AppState {
  final String errorMessage;
  const APIError(this.errorMessage);


  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class HowPageState extends AppState {
  const HowPageState();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
