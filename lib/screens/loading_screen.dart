import 'package:flutter/material.dart';
import '../screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData () async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocation();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(data: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 100.0
        ),
      ),
    );
  }
}
