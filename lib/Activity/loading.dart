import 'package:flutter/material.dart';
import 'package:airvibe_weather_app/Worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String city = "Alappuzha,IN";
  String temp="";
  String hum="";
  String air_speed="";
  String des="";
  String main="";
  String icon="";
  int aqi = 0;
  void startApp(String city) async
  {
    worker instance = worker(location:city);
    await instance.getData();

    temp = instance.temp;
    hum = instance.humidity;
    air_speed = instance.air_speed;
    des = instance.description;
    main = instance.main;
    icon = instance.icon;
    aqi = instance.aqi;
    Future.delayed(Duration(seconds: 2),() {
      if(mounted){
        Navigator.pushReplacementNamed(context, '/home',arguments: {
          "temp_value" : temp,
          "hum_value" : hum,
          "air_speed_value" : air_speed,
          "des_value" : des,
          "main_value" : main,
          "icon_value" : icon,
          "city_value" : city,
          "aqi_value" : aqi
        });
      }
    });


  }
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Map search =  ModalRoute.of(context)?.settings.arguments as Map? ?? {};

    if (search != null && search.isNotEmpty) {
      city = search['searchText'];
    }
    startApp(city);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 200,),
              Image.asset("images/cloudy.png",
                width: 200,
                height: 200,
              ),
              SizedBox(height: 10,),
              Text("AirVibe",
                  style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                      color: Colors.lightBlue[900]
              ),),
                SizedBox(height: 5,),
                Text("Feel the Rhythm of the Atmosphere",
                    style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.lightBlueAccent
                ),),
              SizedBox(height: 15,),
                  Text("Made By Gopika",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue[300],
                        fontWeight: FontWeight.w400
                    ),),
              SizedBox(height: 30,),
        
              SpinKitChasingDots(
                color: Colors.lightBlueAccent,
                size: 50.0,
        ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.lightBlue[50],

      );
  }
}

