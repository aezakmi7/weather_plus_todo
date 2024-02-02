import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/notes_page.dart';
import 'package:weather_app/pages/settings_page.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService('c06ab1b596795f5e40480fdddf007dd1');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    //catch  errors and display message
    catch (e) {
      print(e);
    }
  }

  //weather animations

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'lib/assets/sun.json'; //default sunny
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'lib/assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'lib/assets/rain.json';
      case 'thunderstorm':
        return 'lib/assets/thunder.json';
      case 'clear':
        return 'lib/assets/sun.json';
      default:
        return 'lib/assets/sun.json';
    }
  }

  //init state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetch weather at the beginning  of the app
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(
              _weather?.cityName ?? "Loading...",
              style: GoogleFonts.bebasNeue(fontSize: 40),
            ),

            // lottie animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            //temperature
            Text(
              '${_weather?.temperature.round()}°C',
              style: GoogleFonts.bebasNeue(fontSize: 40),
            ),

            //weather condition
            Text(
              _weather?.mainCondition ?? "",
              style: GoogleFonts.bebasNeue(fontSize: 40),
            ),
            SizedBox(
              height: 25,
            ),

            //button which refresh weather
            ElevatedButton(
              onPressed: () => _fetchWeather(),
              child: Text(AppLocalizations.of(context)!.refreshPage),
            ),

            //sized box
            SizedBox(
              height: 20,
            ),

            //button which navigates to notes
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotesPage()),
                );
              },
              child: Text(AppLocalizations.of(context)!.myNotes),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
              child: Text(AppLocalizations.of(context)!.settings),
            ),
          ],
        ),
      ),
    );
  }
}
