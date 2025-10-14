import 'package:flutter/material.dart';
import '../services/location.dart';
import '../services/networking.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;
  String? apiKey = dotenv.env['api_key'];

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    try {
      Location location = Location();
      await location.getLocation();
      setState(() {
        latitude = location.latitude;
        longitude = location.longitude;
      });
      Network network = Network(url:'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
      var data = await network.getData();
      print(data);

    } catch (e) {
      print('Error retrieving location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => print('askdgf'),
          child: const Text('Get Weather'),
        ),
      ),
    );
  }
}
