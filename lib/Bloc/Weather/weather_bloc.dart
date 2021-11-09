import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:metaweather/Models/weather_model.dart';
import 'package:metaweather/repositories/weather_repositry.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository repo;

  WeatherBloc(WeatherState initialState, this.repo) : super(initialState);
  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield LoadingState();
      try {
        Weather weather = await repo.getWeather();
        yield FetchSuccess(weather: weather);
      } on DioError catch (e) {
        yield ErrorState(message: e.response!.statusMessage.toString());
      }
    }
  }
}
//  if (e.response) {
//     print(e.response.data)
//     print(e.response.headers)
//     print(e.response.requestOptions)
//   } else {
//     print(e.requestOptions)
//     print(e.message)
//   }