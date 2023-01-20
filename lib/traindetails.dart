import 'package:flutter/material.dart';
import 'package:sutt_2_sth/post_main_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sutt_2_sth/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sutt_2_sth/main_screen.dart';


class TrainDetails extends StatefulWidget {
  TrainDetails({required this.trainNo});


  String trainNo;

  @override
  State<TrainDetails> createState() => _TrainDetailsState();
}

Map trainResponse = {};
List listResponse1 = [];

MainScreen journeyS = MainScreen();
MainScreen journeyE = MainScreen();


class _TrainDetailsState extends State<TrainDetails> {

  // int chosenIndex=0;
  // final List<Widget> children = [
  //   TrainData(journeyStart: journeyS.returnJourneyStart(), journeyEnd: journeyE.returnJourneyEnd(),),
  // ];
  // void onItemTapped(int index) {
  //   setState(() {
  //     chosenIndex = index;
  //   });
  // }

  bool isLoading = false;
  Future<dynamic> apiCall2() async {
    isLoading = true;
    Map<String, dynamic> mapdat2 = {
      "trainNo" : widget.trainNo,
    };
    http.Response response;
    Uri uri = Uri.https('irctc1.p.rapidapi.com','api/v1/getTrainSchedule',mapdat2);
    response = await http.get(uri, headers: {
      "X-RapidAPI-Key": "5a915091a0msh6ee56cca99744d3p10be83jsn874e2aa33e1b",
      "X-RapidAPI-Host": "irctc1.p.rapidapi.com",});
    if (response.statusCode == 200) {
      setState(() {
        trainResponse = json.decode(response.body);
        listResponse1 = trainResponse['data']['route'].toList();
        print(listResponse1);
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    apiCall2();
    super.initState();
  }

  TextEditingController stationInputTEC = TextEditingController();

  @override
  Widget build(BuildContext context) => isLoading
      ? Scaffold(
    backgroundColor: Colors.purple,
    body: Center(
      child: SpinKitPouringHourGlass(
        size: 140,
        color: Colors.blue,
      ),
    ),
  )
      : Scaffold(
    backgroundColor: Colors.deepOrangeAccent,
    appBar: AppBar(
      titleSpacing: 00.0,
      centerTitle: true,
      backgroundColor: Colors.orange,
      title: const Text(
        'Trains',
        textAlign: TextAlign.center,
      ),
    ),
    body: ListView.builder(itemBuilder: (context, index){
      return Card(
        color: Colors.orangeAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            Row(

              children: [
                Icon(
                  Icons.code,
                  size: 20,
                  color: Colors.yellow,
                ),
                const Text(
                  "Station Code is: ",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.yellow, fontSize: 20),
                ),
                Text(
                  listResponse1[index]['station_code'].toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.yellow, fontSize: 20),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.dns,
                  size: 20,
                  color: Colors.yellow,
                ),
                const Text(
                  "Station Name is: ",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.yellow, fontSize: 20),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      listResponse1[index]['station_name'].toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.yellow, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: Colors.yellow,
                ),
                const Text(

                  "Day it is passing through is: ",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.yellow, fontSize: 20),
                ),
                Text(
                  listResponse1[index]['day'].toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.yellow, fontSize: 20),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.social_distance,
                  size: 20,
                  color: Colors.yellow,
                ),
                const Text(
                  "Distance from source is: ",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.yellow, fontSize: 20),
                ),
                Text(
                  listResponse1[index]['distance_from_source'].toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.yellow, fontSize: 20),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.verified,
                  size: 20,
                  color: Colors.yellow,
                ),
                const Text(
                  "Will train stop at the station:",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.yellow, fontSize: 20),
                ),
                Text(
                  listResponse1[index]['stop'].toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.yellow, fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      );
    },
      itemCount: listResponse1.length ,
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.pop(context);
      },
      backgroundColor: Colors.redAccent,
      child: const Icon(
        Icons.arrow_back_ios,
        color: Colors.yellowAccent,
      ),
    ),
    // bottomNavigationBar: BottomNavigationBar(
    //   currentIndex: chosenIndex,
    //   selectedItemColor: Colors.blue,
    //   onTap: onItemTapped,
    //   items: const <BottomNavigationBarItem>[
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.arrow_back_ios),
    //       label: 'See Trains again',
    //       backgroundColor: Colors.black,
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.arrow_back_ios),
    //       label: 'Enter Station Again',
    //       backgroundColor: Colors.black,
    //     ),
    //   ],
    // ),
  );

}

// Container(
// padding: const EdgeInsets.all(20.0),
// child: TextFormField(
// style: const TextStyle(
// color: Colors.black,
// ),
// decoration: kTextFieldInputDecoration,
// controller: stationInputTEC,
// ),
