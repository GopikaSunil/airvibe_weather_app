import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController searchController = new TextEditingController();

  String _getAqiDescription(int? aqi) {
    if (aqi == null) return "Unknown";
    switch (aqi) {
      case 1:
        return "Good";
      case 2:
        return "Fair";
      case 3:
        return "Moderate";
      case 4:
        return "Poor";
      case 5:
        return "Very Poor";
      default:
        return "Unknown";
    }
  }


  @override
  void initState() {
    super.initState();
    print("This is a init state");
  }
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print("Set state called");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Widget Destroyed");
  }
  @override
  Widget build(BuildContext context) {
    var city_name = ["Kochi","Chennai","Mumbai","Kolkata","Germany"];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];
    Map info = ModalRoute.of(context)?.settings.arguments as Map? ?? {};

    String temp = (info['temp_value']?.toString() ?? '0');
    String air = (info['air_speed_value']?.toString() ?? "N/A");
    if(temp == "NA")
      {
        print("NA");
      }else{
      temp = (info['temp_value']?.toString() ?? '0');
      if(temp.length>4){
        temp = temp.substring(0,4);
      }else{
        temp = temp;
      }
    }
    if(air == "NA")
    {
      print("NA");
    }else{
      air = (info['air_speed_value']?.toString() ?? "N/A");
      if(air.length>4){
        air = air.substring(0,4);
      }else{
        air = air;
      }
    }
    String icon = info['icon_value'] ?? "No Icon";
    String getcity = info['city_value'] ?? "Unknown City";
    String hum = info['hum_value']?.toString() ?? "N/A";
    String des = info['des_value'] ?? "No Description";
    int? aqi = info['aqi_value'];
    String aqiDescription = _getAqiDescription(aqi);


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.blue[200],
          )),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors:
                    [
                      Colors.white,
                      Color(0xFF90CAF9),
                    ]
                )
              ),
              child: Column(
                children: [
                  Container( //Search Container
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.symmetric(horizontal: 24,vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white38,
                        width: 2.0
                      )
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if((searchController.text).replaceAll(" ", "") == "")
                              {
                                print("Blank search");
                              }else{
                              Navigator.pushReplacementNamed(context, "/loading",arguments: {
                                "searchText" : searchController.text,
                              });
                            }
        
                          },
                          child: Container(child: Icon(Icons.search,color: Colors.lightBlue[800],),margin: EdgeInsets.fromLTRB(3, 0, 7, 0),),
                        ),
                        Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search $city"
                              ),
                            ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    //container-1
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.blue.withOpacity(0.5),
                              border: Border.all(
                                  color: Colors.white38,
                                  width: 2.0
                              )
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          padding: EdgeInsets.all(10),
                          child: Row(children: [
                              Image.network("https://openweathermap.org/img/wn/$icon@2x.png"),
                              SizedBox(width: 10,),
                              Column(
                                children: [
                                  Text("$des",
                                    style: TextStyle(
                                      fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                      color: Colors.white70
                                  ),),
                                  SizedBox(height: 5,),
                                  Text("In $getcity",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54
                                    ),),
                                  SizedBox(height: 10,),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.air,
                                        color: Colors.lightBlue[900],
                                        size: 30,
                                      ),
                                      Text(
                                        "AQI: $aqi",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        aqiDescription,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.lightBlue[900],
                                        ),
                                      ),
        
                                    ],
                                  )
                                ],
                              )
                            ],
                          ) ,
                        ),
                      ),
                    ],
                  ),
        
                  Row(//container-2
                    children: [
                      Expanded(
                          child: Container(
                            height: 180,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.blue.withOpacity(0.5),
                              border: Border.all(
                                  color: Colors.white38,
                                  width: 2.0
                              )
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                          padding: EdgeInsets.all(26),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Icon(WeatherIcons.thermometer,color: Colors.lightBlue[900],),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("$temp",style: TextStyle(
                                    fontSize: 70,
                                    color: Colors.white70,
                                  ),),
                                  Icon(WeatherIcons.celsius,size: 50,color: Colors.lightBlue[900],)
        
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.blue.withOpacity(0.5),
                              border: Border.all(
                                  color: Colors.white38,
                                  width: 2.0
                              )
                          ),
                          margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                          padding: EdgeInsets.all(26),
                          height: 200,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.day_windy,color: Colors.lightBlue[900])
                                ],
                              ),
        
                              SizedBox(height: 20,),
        
                              Text("$air",style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70
                              ),),
                              Text("km/hr",style: TextStyle(
                                color: Colors.lightBlue[900]
                              ),)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.blue.withOpacity(0.5),
                              border: Border.all(
                                  color: Colors.white38,
                                  width: 2.0
                              )
                          ),
                            margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                          padding: EdgeInsets.all(26),
                            height: 200,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.humidity,color: Colors.lightBlue[900])
                                ],
                              ),
        
                              SizedBox(height: 20,),
        
                              Text("$hum",style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70
                              ),),
                              Text("%",style: TextStyle(
                                fontSize: 20,
                                color: Colors.lightBlue[900]
                              ),)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Container(
                    padding: EdgeInsets.all(42),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("AirVibe",style: TextStyle(
                          fontSize: 15
                        ),),
                        Text("Made By Gopika",style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600
                        ),)
                      ],
                    ),
                  )
        
                ],
              ),
            ),
        ),
      ),
    );
  }
}

