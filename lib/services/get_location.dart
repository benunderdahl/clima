import 'package:geolocator/geolocator.dart';

Future<void> getLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // 1️⃣ Check if location services are on
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  // 2️⃣ Check current permission status
  permission = await Geolocator.checkPermission();

  // 3️⃣ If denied, request again
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied.');
    }
  }

  // 4️⃣ If permanently denied, guide user to settings
  if (permission == LocationPermission.deniedForever) {
    await Geolocator.openAppSettings();
    return Future.error('Location permissions are permanently denied.');
  }

  // 5️⃣ Retrieve position if all checks pass
  Position position = await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
    ),
  );

  print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
}
