import 'package:flutter/material.dart';
import 'weather.dart';
import 'remoteservice.dart';

class WeatherPage extends StatefulWidget {
  late int id;

  WeatherPage({super.key,required this.id});
  @override
  _WeatherPage createState() =>  _WeatherPage(id: id);
}


class _WeatherPage extends State<WeatherPage> {
  late int id;

  _WeatherPage({required this.id});
  Weather? weather;
  var isLoaded = false;

  @override
  void initState(){
    super.initState();
    getData();
  }
  getData() async {
    weather = await RemoteService().getWeather();
    if(weather != null){
      setState(() {
        isLoaded = true;
      });
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Lutsk weather"),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return  Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date: ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),),
                      Text(
                          weather!.hourly.time[id].toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          )
                      ), Text(" Temp: ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),),
                      Text(
                          weather!.hourly.temperature2M[id].toString(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      Text(" C",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),),

                    ],)
              );
            }),
        replacement: const Center(
          child: CircularProgressIndicator(),),

      ),
    );
  }
}