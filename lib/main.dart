import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    home: WeatherApp(),
  ));
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  var temperature;
  var weather = 'Завантаження';
  final double latitude = 50.4503596;
  final double longitude = 30.5245025;

  Future<void> getWeather() async {
    final apiKey = '953bb410d5634ae4a58152706240106';
    final response = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$latitude,$longitude&lang=en'));

    if (response.statusCode == 200) {
      var results = jsonDecode(response.body);
      setState(() {
        temperature = results['current']['temp_c'];
        weather = results['current']['condition']['text'];
      });
      print('Temperature: $temperature');
      print('Weather: $weather');
    } else {
      setState(() {
        weather = 'Помилка завантаження даних: ${response.statusCode}';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Погода в Києві'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Київ',
              style: GoogleFonts.roboto(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue[300],
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              temperature != null
                  ? '$temperature\u00B0C'
                  : 'Завантаження',
              style: GoogleFonts.roboto(
                fontSize: 60.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              weather,
              style: GoogleFonts.roboto(
                fontSize: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
