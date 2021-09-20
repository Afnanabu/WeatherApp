import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_registration_screen/FirstPage.dart';
import 'package:login_registration_screen/Login_Screen.dart';
import 'package:login_registration_screen/Registration_Screen.dart';
 import 'Weather.dart';
class HomePage extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor:Colors.transparent,
        leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.blue,),
            onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));}),

        title:TextButton(onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstPage()));},
          child: Text('                                                     '
              '  Edit Your Profile',style: TextStyle(color: Colors.blue),),),
       ),
      body: FutureBuilder(
        future: getWeatherData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text('${snapshot.error} has occurred.'),
            );
          else if (snapshot.hasData) {
            final WeatherData weather = snapshot.data as WeatherData;
            return Container(
              width: double.infinity,
              color: Colors.black,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                        height: 200,
                        child: Image.asset('Image/logo.png')),
                    Text('The Weather in  ${weather.name} ', style: TextStyle(fontSize: 20,color: Colors.blue),),
                    Container(color: Colors.black,
                      width: 200,
                      child: SingleChildScrollView(child: Column(children: [
                       SizedBox(height: 30,),

                        ListTile(
                          leading: Icon(Icons.waves,color: Colors.blue,),
                          title: Text( 'Wind Speed: ${weather.main.feelsLike}'),
                        ),
                        ListTile(
                          leading: Icon(Icons.thermostat_rounded,color: Colors.red,),
                          title: Text( 'Temperature: ${weather.main.tempMax} '),
                        ),
                             ListTile(
                              leading: Icon(Icons.cloud,color: Colors.white,),
                              title: Text( ' Weather: ${weather.main.tempMin}'),
                            ),

                        ListTile(
                           leading: Icon(Icons.wb_sunny,color: Colors.yellow,),
                          title: Text( ' Humidity: ${weather.main.humidity}'),
                        )
                        ],),),)
                  ]),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}