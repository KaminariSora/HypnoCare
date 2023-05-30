import 'package:flutter/material.dart';
import 'package:project/models/transections.dart';
import 'package:project/provider/transection_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class History extends StatelessWidget {
  const History({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransectionProvider();
        })
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Profile(
          title: "ประวัติ",
          navigateBack: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.title, required this.navigateBack});

  final String title;
  final VoidCallback navigateBack;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransectionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Twist',
            shadows: [
              BoxShadow(color: Colors.black, offset: Offset(5, 5), spreadRadius: 10, blurRadius: 10),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
              Color(0xffeeaeca),
              Color(0xff94bbe9),
            ]),
          ),
        ),
        leading: IconButton(
          onPressed: widget.navigateBack,
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Consumer(
        builder: (context, TransectionProvider provider, Widget? child) {
          var count = provider.transection.length; //นับจำนวนข้อมูล
          if (count <= 0) {
            return Center(
              child: Text(
                "ไม่พบข้อมูล",
                style: TextStyle(fontSize: 35),
              ),
            );
          } else {
            return ListView.builder(
              reverse: false,
              itemCount: count,
              itemBuilder: (context, int index) {
                transections data = provider.transection[index];
                return Card(
                  elevation: 8,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/clock.png'),
                      radius: 30,
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          DateFormat("dd/MM/yyyy hh:mm:ss aaa ").format(data.date),
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text("เนื้อ = ${data.dataMeat.toString()} กรัม"),
                        Text("ข้าว = ${data.dataRice.toString()} กรัม"),
                        Text("ผัก = ${data.dataVeget.toString()} กรัม"),
                        Text("ผลไม้ = ${data.dataFruit.toString()} กรัม"),
                        Text("นม = ${data.dataMilk.toString()} มิลลิลิตร"),
                      ],
                    ),
                    dense: true,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
