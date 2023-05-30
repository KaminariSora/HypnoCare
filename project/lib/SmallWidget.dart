import 'package:flutter/material.dart';
import 'package:project/provider/dataCountIcon.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'RowLine.dart';

class SmallWidget extends StatelessWidget {
  final String data, total, unit1, unit2;
  final Image asset1, asset2;
  final double format1, format2, limit;
  DataCount RLsmall = DataCount();
  RowLine RL = RowLine(
    type1: '',
    format1: 2,
    format2: 5,
  );
  double percentOut = 0.00;
  SmallWidget({Key? key, required this.data, required this.total, required this.unit1, required this.unit2, required this.asset1, required this.asset2, required this.format1, required this.format2, required this.limit}) : super(key: key);

  Stream<double> percent() async* {
    double percentIn = 0.00;
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      percentIn = RL.getdataLine() / limit;
      if (percentIn < 1) {
        percentOut = percentIn;
      } else {
        percentOut = 1;
      }
      //print("going to push stream");
      yield percentOut;
    }
  }

  Color _getProgressColor(double percent) {
    if (0.4 >= percent) {
      return Colors.red;
    } else if (0.5 <= percent && percent <= 0.75) {
      return Colors.yellow;
    } else if (0.76 <= percent && percent <= 0.99) {
      print("Percent = " + percent.toString());
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  String _getProgressString(double percent) {
    if (percent <= 0.99) {
      return (percent * 100).toStringAsFixed(0) + "%";
    } else {
      return 'เกินปริมาณที่เหมาะสม';
    }
  }

  Text _getProgressText(double percent) {
    if (percent <= 0.99) {
      return Text((percent * 100).toStringAsFixed(0) + "%");
    } else {
      return Text(
        'เกินปริมาณที่เหมาะสม',
        style: TextStyle(color: Colors.white),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    RL = RowLine(
      type1: data,
      format1: format1,
      format2: format2,
    );

    return Container(
      height: 270,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [
        BoxShadow(blurRadius: 20)
      ]),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 80,
              ),
              asset1,
              asset2
            ],
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 130,
            ),
            Text(
              unit1,
              style: TextStyle(fontFamily: 'Twist'),
            ),
            SizedBox(
              width: 50,
            ),
            Text(
              unit2,
              style: TextStyle(fontFamily: 'Twist'),
            ),
            SizedBox(
              width: 50,
            ),
            Text(
              total,
              style: TextStyle(fontFamily: 'Twist'),
            )
          ],
        ),
        SizedBox(
          height: 30,
        ),
        RL,
        SizedBox(
          height: 30,
        ),
        StreamBuilder(
          stream: percent(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              double percent = snapshot.data as double;
              return LinearPercentIndicator(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                animation: false,
                animationDuration: 1000,
                lineHeight: 20.0,
                percent: percent, // Use snapshot.data here
                center: _getProgressText(percent),
                // ignore: deprecated_member_use
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: _getProgressColor(percent),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),

        // Expanded(child: ElevatedButton(
        //                  onPressed: () {
        //                   print(RL.getdataLine1());
        //                   print(RL.getdataLine2());
        //                   print("Confirm");
        //                  },
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                    children: [
        //                     Text(
        //                       "Confirm",
        //                     ),
        //                   ],
        //                  ),
        //                ), ),
      ]),
    );
  }

  double getRLSmallWidget() {
    //print("RLsmall");
    //print(RL.getdataLine());
    RLsmall.SetData(RL.getdataLine());
    return RLsmall.data ??= 0;
  }
}

/*สูตร 
ผลไม้ 1 ชิ้น 90 g ; เทียบกับน้ำหนักเฉลี่ยของแอปเปิ้ล 1 ชิ้น
ผลไม้ 1 ผล 300 g ; เทียบกับน้ำหนักเฉลี่ยของแอปเปิล 1 ผล
ควรกิน ไม่เกิน 350 g
ไม่กินไม่เป็นไร ไม่ต้องใส่แดง
นม 1 แก้ว 200 ml
นม 1 กล่อง 250 ml 
ควรกิน 3-4 แก้วต่อวัน ; 1000 >= milk >= 500
8วรกินให้มากกว่า 2 แก้วต่อวันในวัยผู้ใหญ่
*/