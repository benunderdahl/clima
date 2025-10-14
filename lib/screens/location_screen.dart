import 'package:flutter/material.dart';
import 'package:clima/util/constants.dart';

class LocationScreen extends StatefulWidget {

  final dynamic data;

  LocationScreen({
    super.key,
    this.data
  });

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  late double temp;
  late int condition;
  late String city;

  @override
  void initState() {
    super.initState();
    updateUI(widget.data);
  }
  
  void updateUI(dynamic data) {
    setState(() {
       temp = data['main']['temp'];
        condition = data['weather'][0]['id'];
        city = data['name'];
    });
   
  }
  
  @override
  Widget build(BuildContext context) {
    var city = widget.data['name'];
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
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
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
                      '☀️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "It's 🍦 time in $city!",
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


        // var condition = data["weather"][0]["main"];
        // var id = data["weather"][0]["id"];
        // var temp = data["main"]["temp"];
        // var city = data["name"];
        