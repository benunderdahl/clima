import 'package:http/http.dart' as http;
import 'dart:convert';


class Network {
  
  final String url;

  Network({
    required this.url,
  });

  Future getData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return print('Request failed: ${response.statusCode}');
      }
  } catch (e) {
      print('Error fetching weather data: $e');
    }
  }






}