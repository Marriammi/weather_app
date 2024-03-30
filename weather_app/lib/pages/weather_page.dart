import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/services/weather_servise.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('3ccda596413c77844a79d68a6fe44261');
  Weather? _weather;

  //fetch weaather
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentlyCity();

    // get weather city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    //errors
    catch (e) {
      print(e);
    }
  }

  //weather animation
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloud.json';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/fog.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  //init state
  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 100),
              child: Icon(
                Icons.location_on,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              ),
            ),
            //city name
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                _weather?.cityName ?? "Loading city...",
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),

            //weather animation
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   _weather?.mainCondition ?? "",
                  //   style: TextStyle(fontSize: 20.0),
                  // ),
                  // SizedBox(height: 15.0),
                  Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
                ],
              ),
            ),

            //temperature
            Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: Text(
                "${_weather?.temperature.round()}°C",
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
