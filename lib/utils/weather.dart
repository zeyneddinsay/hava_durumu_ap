import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

import 'package:hava_durumu_app/utils/location.dart';

import 'location.dart';

const apiKey = "98fa014f3730e6b7d59a6970f2f26e94";

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;
  WeatherDisplayData({
    required this.weatherIcon,
    required this.weatherImage,
  });
}

class WeatherData {
  WeatherData({required this.locationData});

  LocationHelper locationData;
  var currentTemperature;
  var currentCondition;

  Future<void> getCurrentTemperature() async {
    Response response = await get(Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric"));

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      debugPrint("apiden deger gelmiyor");
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition < 600) {
      return WeatherDisplayData(
          weatherIcon: Icon(
            FontAwesomeIcons.cloud,
            size: 70,
            color: Colors.white,
          ),
          weatherImage: AssetImage('assets/bulutlu.png'));
    } else {
      var now = new DateTime.now();
      if (now.hour >= 19) {
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.moon,
              size: 70,
              color: Colors.white,
            ),
            weatherImage: AssetImage('assets/gece.png'));
      } else {
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.sun,
              size: 70,
              color: Colors.white,
            ),
            weatherImage: AssetImage('assets/gunesli.png'));
      }
    }
  }
}
