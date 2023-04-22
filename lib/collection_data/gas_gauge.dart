import 'package:elegant_notification/elegant_notification.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Gas_Gauge extends StatelessWidget {
  const Gas_Gauge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseReference gas =
        FirebaseDatabase.instance.ref().child('Air quality');
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: FutureBuilder(
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
            stream: gas.child('/ggg/gas level').onValue,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final gauge_gas = snapshot.data!.snapshot.value;

              print('gas : $gauge_gas');

              return Gauge(
                pointerr: double.parse(gauge_gas.toString()),
              );
            },
          );
        },
      ),
    );
  }
}

class Gauge extends StatefulWidget {
  const Gauge({super.key, required this.pointerr});
  final double pointerr;

  @override
  State<Gauge> createState() => _GaugeState();
}

class _GaugeState extends State<Gauge> {
  @override
  Widget build(BuildContext context) {
    if (widget.pointerr > 50) {
      if (mounted) {
        Future.delayed(Duration(seconds: 3), () {
          ElegantNotification.error(
                  toastDuration: Duration(seconds: 5),
                  title: Text("Danger"),
                  description: Text("Gas level is too high"))
              .show(context);
        });
      }
    }
    return SfRadialGauge(
      axes: [
        RadialAxis(minimum: 0, maximum: 100, interval: 5, ranges: [
          GaugeRange(
              startValue: 0,
              endValue: widget.pointerr,
              color: Color(0xffFF1651)),
        ], pointers: [
          NeedlePointer(value: widget.pointerr)
        ], annotations: [
          GaugeAnnotation(
              widget: Container(
                  margin: EdgeInsets.only(bottom: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('${widget.pointerr}',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      if (widget.pointerr < 50)
                        Text('GOOD',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      if (widget.pointerr >= 50)
                        Text('NOT GOOD',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                    ],
                  )),
              angle: 90,
              positionFactor: 0.5)
        ]),
      ],
    );
  }
}
