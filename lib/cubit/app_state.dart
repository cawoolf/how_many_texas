import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:how_many_texas/data/model/search_result.dart';


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

  final SearchResult aiResult;
  const APILoaded(this.aiResult);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class APIError extends AppState {
  final String errorMessage;
  const APIError(this.errorMessage);

  // // Still not sure about what this is for..
  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;
  //
  //   return other is APIError && other.errorMessage == errorMessage;
  // }
  //
  // @override
  // int get hashCode => errorMessage.hashCode;

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
