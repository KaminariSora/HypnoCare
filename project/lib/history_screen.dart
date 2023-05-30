import 'package:project/model/Mbmi.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:project/providers/bmi_provider.dart';

//import 'main.dart';

class HistoryScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "BMI History",
            style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'Itim'),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                Color(0xffeeaeca),
                Color(0xff94bbe9)
              ]),
            ),
          ),
        ),
        body: Consumer(
          builder: (context, BmiProvider provider, child) {
            var count = provider.mobmi.length;
            if (count <= 0) {
              return Center(
                child: Text(
                  "ไม่พบข้อมูล",
                  style: const TextStyle(fontSize: 20),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, int index) {
                    Mbmi data = provider.mobmi[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xffeeaeca),
                          radius: 30,
                          child: Text(
                            data.nbmi.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        title: Text(data.mess),
                        subtitle: Text(DateFormat.yMd().add_jm().format(data.date)),
                      ),
                    );
                  });
            }
          },
        ));
  }
}
