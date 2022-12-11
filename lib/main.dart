import 'package:flutter/material.dart';
import 'remoteservice.dart';
import 'weather.dart';
import 'weatherpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}):super (key:key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late int id;
  Weather? weather;
  var isLoaded = false;

  @override
  void initState(){
    super.initState();
    getData();
  }
  late List<String> date = weather!.hourly.time.map((e) => e.toString()).toList();
  late int selectedid = 0;
  late String selected = date[selectedid].toString();
  getData() async {
    weather = await RemoteService().getWeather();

    if(weather != null){
      setState(() {
        isLoaded = true;

      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Lutsk weather"),
      ),
      body: Center(
        child: Column(

          children: [
            Container(
              margin: EdgeInsets.fromLTRB(100, 0, 75, 0),
              child: Text("Select date and time",
              style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),),),
            Container(
              margin: EdgeInsets.fromLTRB(100, 10, 75, 0),
              child: DropdownButton<String>(
                value: selected,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: date

                    .map((clock) =>
                    DropdownMenuItem(
                      value: clock,
                      child: Text(clock),
                      onTap: (){ selectedid = date.indexOf(clock);},
                    ))
                    .toList(),
                onChanged: (String? item){Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        WeatherPage(id: selectedid))); }
                ,
              ),
            ),




          ],
        ),
      ),);}}
