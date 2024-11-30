import 'package:http/http.dart';
import 'dart:convert';
class worker
{
  String location="";

  //constrcutor
  worker({required this.location})
  {
    location = this.location;
  }

  String temp="";
  String humidity="";
  String air_speed="";
  String description="";
  String main="";
  String icon="";
  int aqi = 0;


  //method
  Future<void> getData() async
  {
    try{
      //get data
      Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$location&appid=053f21a0ebdc8212ee883bd5358aa42c'));
      Map data = jsonDecode(response.body);

      //Getting Temp,Humidity
      Map temp_data = data['main'];
      String getHumidity = temp_data['humidity'].toString();
      double getTemp = temp_data['temp'] - 273.15; // fahrenheit to celsius

      //Getting air_speed
      Map wind = data['wind'];
      double getAir_speed = wind['speed']/0.27777777778; //meter per second to km per hour

      //rounding speed
      String roundSpeed = getAir_speed.toStringAsFixed(2);


      //Getting Description
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getMain_des = weather_main_data['main'];
      String getDesc = weather_main_data['description'];

      double lat = data['coord']['lat'];
      double lon = data['coord']['lon'];
      Response aqiResponse = await get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=053f21a0ebdc8212ee883bd5358aa42c'));
      Map aqiData = jsonDecode(aqiResponse.body);
      int getAqi = aqiData['list'][0]['main']['aqi'];



      //Assigning values
      temp = getTemp.toString(); //C
      humidity = getHumidity.toString(); // %
      air_speed = roundSpeed; //km/hr
      description = getDesc;
      main = getMain_des;
      icon = weather_main_data["icon"].toString();
      aqi = getAqi;



    }catch(e)
    {
      temp = "NA";
      humidity = "NA";
      air_speed = "NA";
      description = "Can't Find Data";
      main = "NA";
      icon = "03d";
      aqi = 0;
    }




  }

}

