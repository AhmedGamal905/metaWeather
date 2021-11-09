part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {}

class InitialState extends WeatherState {
  @override
  List<Object> get props => [];
}

class LoadingState extends WeatherState {
  @override
  List<Object> get props => [];
}

class FetchSuccess extends WeatherState {
  final Weather weather;
  FetchSuccess({required this.weather});
  @override
  List<Object> get props => [weather];
}

class ErrorState extends WeatherState {
  final String message;
  ErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
