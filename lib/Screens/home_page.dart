import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:metaweather/Bloc/Weather/weather_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late WeatherBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<WeatherBloc>(context);
    bloc.add(FetchWeather());
    _backGroundTimeCheck();
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  AssetImage background = const AssetImage("assets/Images/back1.jpg");
  final AssetImage background1 = const AssetImage("assets/Images/back1.jpg");
  final AssetImage background2 = const AssetImage("assets/Images/back2.jpg");

  _backGroundTimeCheck() {
    if (DateTime.now().hour > 6) {
      background = background2;
    } else {
      background = background1;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String timeNow = DateFormat('hh:mm').format(now).toString();
    String dateNow = DateFormat('E, d').format(now).toString();

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is FetchSuccess) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: background,
                  fit: BoxFit.cover,
                ),
              ),
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Text(
                        dateNow,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        timeNow,
                        style: const TextStyle(
                          fontSize: 70,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.wb_sunny_sharp,
                                      color: Colors.amber,
                                      size: 45,
                                    ),
                                    Text(
                                      state.weather.currentWeather.temperature
                                              .toInt()
                                              .toString() +
                                          "°",
                                      style: const TextStyle(
                                        fontSize: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                endIndent: 16,
                                indent: 16,
                                thickness: 2,
                                color: Colors.white24,
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            state.weather.currentWeather
                                                    .windspeed
                                                    .toInt()
                                                    .toString() +
                                                " Km",
                                            style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Text(
                                            "wind speed",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const VerticalDivider(
                                      thickness: 2,
                                      color: Colors.white24,
                                      endIndent: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            state.weather.currentWeather
                                                .winddirection
                                                .toInt()
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Text(
                                            'Wind direction',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const VerticalDivider(
                                      thickness: 2,
                                      color: Colors.white24,
                                      endIndent: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            state.weather.hourlyUnits
                                                .temperature2M
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Text(
                                            'Temp unit',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 120,
                    color: Colors.transparent,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.weather.hourly.time.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        DateTime parseDate = DateFormat("yyyy-MM-ddTHH:mm")
                            .parse(state.weather.hourly.time[index]);
                        DateTime inputDate =
                            DateTime.parse(parseDate.toString());
                        DateFormat outputDateFormat = DateFormat('MM/dd');
                        DateFormat outputTimeFormat = DateFormat('HH:mm');
                        String formatedDate =
                            outputDateFormat.format(inputDate);
                        String formatedTime =
                            outputTimeFormat.format(inputDate);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 65,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        formatedDate,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                      ),
                                      Text(
                                        formatedTime,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.wb_sunny_sharp,
                                    color: Colors.amber,
                                    size: 25,
                                  ),
                                  Text(
                                    state.weather.hourly.temperature2M[index]
                                            .toInt()
                                            .toString() +
                                        "°",
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is LoadingState) {
            return const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: Colors.redAccent,
                ),
              ),
            );
          } else if (state is ErrorState) {
            return Center(
              child: Text(
                "Something went wrong: " + state.message.toString(),
              ),
            );
          } else {
            return const Text("SomeThing is Wrong");
          }
        },
      ),
    );
  }
}
