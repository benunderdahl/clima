import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/util/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {

  final dynamic data;

  LocationScreen({
    super.key,
    required this.data
  });

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  late int temp;
  late int condition;
  late String city;

  @override
  void initState() {
    super.initState();
    updateUI(widget.data);
  }
  
  void updateUI(dynamic data) {
    setState(() {
      if (data == null) {
        temp = 0;
        condition = 0;
        city = "";
        return;
      } else {
       double temper = data['main']['temp'];
       temp = temper.toInt();
        condition = data['weather'][0]['id'];
        city = data['name'];
      }
    });
   
  }
  
  @override
  Widget build(BuildContext context) {
    
    WeatherModel weather = WeatherModel();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withValues(), BlendMode.dstATop
                ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocation();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedCity = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedCity != null) {
                        var weatherData = await weather.getTypedLocation(typedCity);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weather.getWeatherIcon(condition),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "${weather.getMessage(temp)} in $city!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
