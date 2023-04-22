import 'package:firebase_database/firebase_database.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
class Temp_RH extends StatelessWidget {
  const Temp_RH({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseReference TempRH = FirebaseDatabase.instance.ref().child('Air quality');
    return Container(
      margin: EdgeInsets.all(10),
      height: 125,
      width: double.infinity,
      //color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          temp_rh(TempRH: TempRH.child('ttt/temp') , title: 'Temperature', first: CommunityMaterialIcons.thermometer, secound: CommunityMaterialIcons.temperature_celsius,),

          temp_rh(TempRH: TempRH.child('hhh/RH') , title: 'Humidity', first: Icons.opacity, secound: CommunityMaterialIcons.percent,),
          temp_rh(TempRH: TempRH.child('ppp/PMML') , title: 'PMML', first: CommunityMaterialIcons.air_humidifier, secound: CommunityMaterialIcons.percent,),

        ],
      ),
    );
  }
}

class temp_rh extends StatelessWidget {
  const temp_rh({
    super.key,
    required this.TempRH,
  required this.title,
  required this.first,
  required this.secound
  });

  final DatabaseReference TempRH;
  final String title ;
  final IconData first ;
  final IconData secound ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$title ', style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold),),
        SizedBox(height: 18,),
        Row(
          children: [
            title == 'PMML'?Container():Icon(first),
            FutureBuilder(
              builder: (ctx,futureSnapshot){
                if(futureSnapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                return StreamBuilder(
                    stream: TempRH.onValue ,
                    builder: (ctx,snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final temp = snapshot.data!.snapshot.value;
                      return Row(
                        children: [
                        Text("${temp}",style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold),),
                          Icon(secound),
                        ],
                      );
                    }
                );
              },
            ),
          ],
        )

      ],
    );
  }
}
