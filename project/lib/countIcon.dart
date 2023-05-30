// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';
import 'package:project/provider/dataCountIcon.dart';

class CountIcon extends StatefulWidget {
  final DataCount datacount;

  const CountIcon({super.key, required this.datacount});

  @override
  State<CountIcon> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CountIcon> {
  int num = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: 80,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (num > 0) {
                  num -= 1;
                  widget.datacount.SetData(num.toDouble());
                }
              });
            },
            child: Container(
              width: 23,
              height: 25,
              child: Image.asset(
                'assets/images/chevron-left.png',
              ),
            ),
          ),
          SizedBox(
            width: 0,
          ),
          Text(
            num.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 1.5,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 0,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (num < 9) {
                  num += 1;
                } else {
                  num == 9;
                }
                widget.datacount.SetData(num.toDouble());
                print(widget.datacount.data);
              });
            },
            child: Container(
              width: 23,
              height: 25,
              child: Image.asset(
                'assets/images/chevron-right.png',
              ),
            ),
          ),
        ],
      ),
    );
  }

  double getDataIcon() {
    return widget.datacount.data ??= 0;
  }
}
