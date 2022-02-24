import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hava_durumu_app/screens/loading_screnn.dart';
import 'package:hava_durumu_app/utils/weather.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
    required this.weatherData,
  }) : super(key: key);

  final WeatherData weatherData;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var temperature;
  var weatherDisplayIcon;
  AssetImage? backgroundImage;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature.round();
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(image: backgroundImage!, fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(child: weatherDisplayIcon),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                '$temperature°',
                style: TextStyle(
                    color: Colors.white, fontSize: 80, letterSpacing: -5),
              ),
            )
          ],
        ),
      ),
    );
  }
}
