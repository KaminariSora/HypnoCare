import 'package:flutter/material.dart';

class HomeBox extends StatelessWidget {
  String title = "";
  String text = "";
  Color color = Colors.black;

  HomeBox(this.title, this.text, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(10),
        //Shadow
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      height: 150,
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.right,
          ))
        ],
      ),
    );
  }
}
