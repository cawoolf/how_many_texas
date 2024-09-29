import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';


// Needs to extends Equatable
@immutable
abstract class WorkingAppState extends Equatable{
  const WorkingAppState();
}

class WelcomePageState extends WorkingAppState {
  const WelcomePageState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class MoneyPageState extends WorkingAppState {
  const MoneyPageState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class HomePageState extends WorkingAppState {
  const HomePageState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class APILoadingState extends WorkingAppState {
  const APILoadingState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class APILoaded extends WorkingAppState {

  const APILoaded();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class APIError extends WorkingAppState {
  final String errorMessage;
  const APIError(this.errorMessage);


  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class HowPageState extends WorkingAppState {
  const HowPageState();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
