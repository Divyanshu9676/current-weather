import 'dart:convert';
import 'package:flutter_weather_app/utils/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

const apiKey = '33383392f9a14b130fbf22d6d72f0fbb';

class WeatherData {
  WeatherData({@required this.locationData});

  LocationHelper locationData;
  double currentTemperature;
  int currentCondition;
  String currentLocation;

  Future<void> getCurrentTemperature() async {
    Response response = await get(
        'http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=$apiKey&units=metric');

    if (response.statusCode == 200) {
      var currentWeather = jsonDecode(response.body);
      print(currentWeather);
      try {
        currentTemperature = currentWeather['main']['temp'].toDouble(); //Doubt?
        currentCondition = currentWeather['weather'][0]['id'];
        currentLocation = currentWeather['name'];
      } catch (e) {
        print(e);
      }
    } else {
      print('Could not fetch temperature!');
    }
  }
}
