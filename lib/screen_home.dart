
import 'package:airquality/collection_data/gas_gauge.dart';
import 'package:airquality/collection_data/temp_rh.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Air Quality'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Gas_Gauge(),
          Text('GAS LEVEL', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
          SizedBox(height: 60,),
          Temp_RH(),

        ],
      )
    );
  }
}
