import 'package:flutter/material.dart';
import 'package:project/provider/dataCountIcon.dart';

import 'RowLineText.dart';
import 'countIcon.dart';

class RowLine extends StatelessWidget {
  final DataCount datacount1 = DataCount();
  final DataCount datacount2 = DataCount();
  double result = 0;
  final String type1;
  final double format1, format2;

  RowLine({
    Key? key,
    required this.type1,
    required this.format1,
    required this.format2,
  }) : super(key: key);

  Stream<double> TextData() async* {
    int data = 0;
    while (data <= 0) {
      await Future.delayed(Duration(seconds: 0));
      getdataLine();
      //print("going to push stream");
      //data = newdata;
      yield getdataLine();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        Padding(
          padding: EdgeInsets.zero,
          child: Container(
            alignment: Alignment.center,
            height: 34,
            //color: Colors.amber,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Container(
            alignment: Alignment.center,
            height: 34,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    type1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Twist',
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: CountIcon(
                  datacount: datacount1,
                )),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: CountIcon(
                  datacount: datacount2,
                )),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: StreamBuilder(
                        stream: TextData(),
                        builder: (context, snapshot) {
                          return RowLineText(
                            externalData: snapshot.data.toString(),
                          );
                        })),
                // Expanded(child: ElevatedButton(
                //         onPressed: () {
                //           getdataLine();
                //           print(getdataLine());
                //           print("Confirm");
                //         },
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Text(
                //               "Confirm",
                //             ),
                //           ],
                //         ),
                //       ), )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  double getdataLine() {
    //print("getdataline");
    double d1 = datacount1.data ??= 0.0;
    double d2 = datacount2.data ??= 0.0;
    result = (d1) * format1 + (d2) * format2;
    return result;
  }

  double getdataLine1() {
    return datacount1.data ??= 0;
  }

  double getdataLine2() {
    return datacount2.data ??= 0;
  }
}
