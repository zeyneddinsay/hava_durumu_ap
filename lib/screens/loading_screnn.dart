import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hava_durumu_app/screens/main_screen.dart';
import 'package:hava_durumu_app/utils/location.dart';
import 'package:hava_durumu_app/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocationHelper? locationData;
  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData!.getCurrentLocation();

    if (locationData!.latitude == null || locationData!.longitude == null) {
      debugPrint("konum gelmiyor");
    } else {
      debugPrint("latitude" + locationData!.latitude.toString());
      debugPrint("longitude" + locationData!.longitude.toString());
    }
  }

  void getWeatherData() async {
    await getLocationData();

    WeatherData weatherData = WeatherData(locationData: locationData!);
    await weatherData.getCurrentTemperature();

    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      debugPrint("apiden bilgi boş dönüyor");
    }

    Navigator.pushReplacement(this.context,
        MaterialPageRoute(builder: (context) {
      return MainScreen(
        weatherData: weatherData,
      );
    }));
  }

  @override //initstate yapıldığında projeyi tamamen durdurup tekrar çalıştırmak gerekiyor
  //proje başlarken ilk çalışacak komutlar burda çalışır
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple, Colors.blue])),
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 150,
          duration: Duration(milliseconds: 1200),
        ),
      ),
    );
  }
}
