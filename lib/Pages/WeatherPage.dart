import 'package:flutter/material.dart';
import 'package:habits/models/weather_model.dart';
import 'package:habits/services/weather_services.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  final String name;
  // final ThemeData current;
  const WeatherPage({Key? key, required this.name});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService _weatherService =
      WeatherService('a0b76e852e16d9df93a369ef64989e31');
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  // Fetch weather data
  void _fetchWeather() async {
    try {
      String cityName = await _weatherService.getCurrentCity();
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      ),
      body: Center(
        child: _buildWeatherInfo(),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  Widget _buildWeatherInfo() {
    if (_weather == null) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).colorScheme.primary,
        ),
      ); // Display loading indicator if weather data is not fetched yet
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _weather?.cityName ?? "Loading City...",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 24, // Adjust font size as needed
                  color: Colors.black, // Set text color
                  fontWeight: FontWeight.bold, // Apply font weight
                ),
          ),
          Lottie.asset(
            _getLottieAnimation(_weather?.mainCondition),
            // width: 100,
            // height: 100,
          ),
          Text(
            '${_weather?.temperature.round()}°C',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20, // Adjust font size as needed
                  color: Colors.blue, // Set text color
                  fontWeight: FontWeight.bold, // Apply font weight
                ),
          ),
          Text(
            _weather?.mainCondition ?? "Loading City...",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16, // Adjust font size as needed
                  color: Colors.grey, // Set text color
                  fontStyle: FontStyle.italic, // Apply italic style
                ),
          ),
          Text(
            _getActivity(_weather?.mainCondition),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 20, // Adjust font size as needed
                  color: Colors.green, // Set text color
                  fontWeight: FontWeight.normal, // Apply font weight
                ),
          ),
        ],
      );
    }
  }

  String _getLottieAnimation(String? weatherCondition) {
    switch (weatherCondition) {
      case 'Clear':
        return 'assets/Sunny.json';
      case 'Clouds':
        return 'assets/Sunny.json';
      case 'Rain':
        return 'assets/ThunderStorm.json';
      case 'Snow':
        return 'assets/Sunny.json';
      default:
        return 'assets/Sunny.json';
    }
  }

  String _getActivity(String? weatherCondition) {
    switch (weatherCondition) {
      case 'Clear':
        return 'Go for a jog or outdoor yoga.';
      case 'Clouds':
        return 'Enjoy a walk in the park or go for a bike ride.';
      case 'Rain':
        return 'Stay indoors and do indoor cardio or strength training.';
      case 'Snow':
        return 'Try skiing or snowboarding at a nearby ski resort.';
      default:
        return 'Stay tuned for more activities!';
    }
  }
}
