import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_weather/services/Network.dart';
import 'package:simple_weather/services/Location.dart';
final String API_KEY = "84c2565d018a4ba7293986078886029f";

Future<dynamic> getLocation() async {
  print("Hello World");
  Location location = Location();
  await location.determinePosition();
  await location.getLocation();
  return await getDataFromLocation( lat: location.lat , long: location.long);
}

Future<dynamic> getDataFromLocation({ lat : double , long : double}) async {
  ApiCall Data = ApiCall(api : "http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$API_KEY");
  await Data.fetchData();
  return await Data.getJSON();
}


class MainScreen extends StatefulWidget {

  var jsonData;

  MainScreen({Key? key, @required this.jsonData }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.jsonData = await getLocation();
         setState(() {
           print("hello ji h");

         });
        print("${widget.jsonData}");
         return Future.delayed(Duration(seconds: 1) );
         },
      child: ListView(

        children: List.generate(1,  (f) => Container(
          color: Colors.yellow,
          child: Stack(
            children: [
              WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [Colors.white, Colors.white],
                    [Colors.white60, Colors.white60],
                    [Colors.white38, Colors.white38],
                    [Colors.white12, Colors.white12]
                  ].reversed.toList(),
                  durations: [35000, 19440, 10800, 8000],
                  heightPercentages: [0.18, 0.22, 0.25, 0.28],
                  blur: MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.bottomCenter,
                  gradientEnd: Alignment.topCenter,
                ),
                size: Size(double.infinity, MediaQuery.of(context).size.height),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              ),
              Positioned.fill(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Text("${widget.jsonData['name']}", style: GoogleFonts.roboto(
                            fontSize: 38,
                            fontWeight: FontWeight.w400
                        )),
                        Text("${widget.jsonData['weather'][0]['main']}", style: GoogleFonts.roboto(
                            fontSize: 18
                        ),),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${(widget.jsonData['main']['temp'] -273.15).toStringAsFixed(1)}", style: GoogleFonts.lato(fontSize: 52),),Text("°", style: TextStyle(fontSize: 40),),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Container(
                                    color: Colors.black12,
                                    width: 2,
                                    height: 30,

                                  ),
                                ),
                                Column(
                                  children: [Text("${(widget.jsonData['main']['temp_min'] -273.15).toStringAsFixed(1) }°",style: GoogleFonts.lato(fontSize: 18)), Center(child: Container(color: Colors.grey,height: 2,)),Text("${(widget.jsonData['main']['temp_max'] -273.15).toStringAsFixed(1)}°",style: GoogleFonts.lato(fontSize: 18))],
                                )
                              ],
                            )

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

Future<Null> _refreshLocalGallery() async{
  print('refreshing stocks...');

}


