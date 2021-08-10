import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:simple_weather/services/Location.dart';
import 'package:simple_weather/services/Network.dart';
import 'package:simple_weather/screens/MainScreen/screen.dart';

final String API_KEY = "84c2565d018a4ba7293986078886029f";

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void getLocation(context) async {
    print("Hello World");
    Location location = Location();
    await location.determinePosition();
    await location.getLocation();
    print("latitude : ${location.lat}| Longitude : ${location.long}");
    getDataFromLocation( lat: location.lat , long: location.long , context: context);
  }

  void getDataFromLocation({ lat : double , long : double , context : BuildContext}) async {
    ApiCall Data = ApiCall(api : "http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$API_KEY");
    await Data.fetchData();
    var jsonData = await Data.getJSON();
    Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(jsonData: jsonData ) ));
  }

  @override
  void initState() {
    getLocation(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: LoadingBouncingGrid.square(
          borderColor: Colors.cyan,
          borderSize: 1.0,
          size: 50.0,
          backgroundColor: Colors.blueAccent,
          duration: Duration(milliseconds: 1000),
        ),
      ),
    );
  }
}
