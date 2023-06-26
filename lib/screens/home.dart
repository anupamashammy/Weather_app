// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_api/constants/constants.dart' as k;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic  isLoaded = false;
  num? temp;
  num? press;
  num? hum;
  num? cover;
  String? cityname;
  TextEditingController controller =TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff33ccff),
              Color(0xffff99cc),
              Color(0xff090979),
            ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          ),
          child: Visibility(
              visible: isLoaded,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.09,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(20)
                        ),
                        
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: controller,
                            onFieldSubmitted: (String city) {
                              setState(() {
                                cityname= city;
                                getCityWeather(city);
                                isLoaded = false;
                                controller.clear();
                              });
                            },
                            cursorColor: Colors.white,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                             hintText: 'Search city',
                            helperStyle: TextStyle(fontSize: 18,color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                            ),
                            
                           border: InputBorder.none,
                            prefixIcon: Icon(Icons.search,
                            size: 25,
                            )

                          ),
                          ),
                        ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(Icons.pin_drop,
                        size: 40,
                        color: Colors.red,
                        ),
                        Text(
                                   cityname!,
                                   overflow: TextOverflow.ellipsis,
                                   style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),

                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,

                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.12,
                    margin: EdgeInsets.symmetric(vertical: 10,
                    ),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade900,
                        offset: Offset(1, 2),
                        blurRadius: 3,
                        spreadRadius: 1,
                      ),
                    ]),
                    child: Row(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Image(image: AssetImage('lib/assets/imagesss/thermometer.png'),
                        //   fit: BoxFit.cover,
                        //   width: MediaQuery.of(context).size.width*0.09,
                        //   ),
                        // ),
                        SizedBox(
                          width: 10,

                        ),
                        Text('Temperature :${temp?.toStringAsFixed(4)} °C',
                        style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.w600,
                        ),
                        )
                      ],
                    ),
                  ),


                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.12,
                    margin: EdgeInsets.symmetric(vertical: 10,
                    ),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade900,
                        offset: Offset(1, 2),
                        blurRadius: 3,
                        spreadRadius: 1,
                      ),
                    ]),
                    child: Row(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Image(image: AssetImage('lib/assets/imagesss/borometer.png'),
                        //   fit: BoxFit.cover,
                        //   width: MediaQuery.of(context).size.width*0.010,
                        //   ),
                        // ),
                        SizedBox(
                          width: 10,

                        ),
                        Text('Pressure :${press?.toStringAsFixed(2)} hpa',
                        style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.w600,
                        ),
                        )
                      ],
                    ),
                  ),



                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.12,
                    margin: EdgeInsets.symmetric(vertical: 10,
                    ),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade900,
                        offset: Offset(1, 2),
                        blurRadius: 3,
                        spreadRadius: 1,
                      ),
                    ]),
                    child: Row(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Image(image: AssetImage('lib/assets/imagesss/humidity.png'),
                        //   fit: BoxFit.cover,
                        //   width: MediaQuery.of(context).size.width*0.09,
                        //   ),
                        // ),
                        SizedBox(
                          width: 10,

                        ),
                        Text('Humidity :${hum?.toStringAsFixed(2)} %',
                        style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.w600,
                        ),
                        )
                      ],
                    ),
                  ),


                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.12,
                    margin: EdgeInsets.symmetric(vertical: 10,
                    ),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade900,
                        offset: Offset(1, 2),
                        blurRadius: 3,
                        spreadRadius: 1,
                      ),
                    ]),
                    child: Row(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Image(image: AssetImage('lib/assets/imagesss/cloud cover.jpg'),
                        //   fit: BoxFit.cover,
                        //   width: MediaQuery.of(context).size.width*0.09,
                        //   ),
                        // ),
                        SizedBox(
                          width: 10,

                        ),
                        Text('Cloud Cover :${cover?.toInt()} %',
                        style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.w600,
                        ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              
              replacement: Center(
                child: const CircularProgressIndicator(),
              )),
        ),
      ),
    );
  }

  void getCurrentLocation() async {
    var p = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      forceAndroidLocationManager: true,
    );
    if (p != null) {
      print('Lat:${p.latitude}, Long:${p.longitude}');

      getCurrentCityWeather(p);
    } else {
      print('Date is not here');
    }

   
  }

   getCityWeather(String cityname) async {
      var client = http.Client();
      var uri = '${k.domain}q=$cityname&appid=${k.apikey}';
      var url = Uri.parse(uri); 
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var data = response.body;
        var decodeDate = json.decode(data);
        log(data);

        setState(() {
          isLoaded = true;
        });
        updateUI(decodeDate);
      } else {
        print(response.statusCode);
      }
    }

  void getCurrentCityWeather(Position position) async {
    var client = http.Client();
    var uri =
        '${k.domain}lat=${position.latitude}&lon=${position.longitude}&appid=${k.apikey}';
    var url = Uri.parse(uri); // Corrected line: Uri.parse instead of uri.parse  
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodeDate = json.decode(data);
      log(data);
      updateUI(decodeDate);

      setState(() {
        isLoaded = true;
      });
    } else {
      print(response.statusCode);
    }
  }

  void updateUI(var decodeDate ) {
    setState(() {
       if(decodeDate ==null){
      temp = 0;
      press= 0;
      hum =  0;
      cover =0;
      cityname ='Not available';

    }else{
      temp = decodeDate['main']['temp']-273;
      press= decodeDate['main']['pressure'];
      hum =  decodeDate['main']['humidity'];
      cover =decodeDate['clouds']['all'];
      cityname =decodeDate['name'];
    }
    });
   
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
