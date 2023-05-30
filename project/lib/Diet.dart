import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project/BigWidget1.dart';
import 'package:project/MainScreen.dart';
import 'package:project/SmallWidget.dart';
import 'package:project/models/transections.dart';
import 'package:project/provider/transection_provider.dart';
import 'package:project/screen/history.dart';
import 'package:provider/provider.dart';

class Diet extends StatelessWidget {
  Diet({super.key});

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
        home: Weight(
          title: 'Flutter Demo Home Page',
          navigateBack: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class Weight extends StatelessWidget {
  final VoidCallback navigateBack;
  BigWidget1 Bwg = BigWidget1();
  SmallWidget Swg1 = SmallWidget(
    total: 'รวม(กรัม)',
    data: 'ผลไม้',
    unit1: '  ชิ้น', //ขอลักไก่หน่อยละกัน ไม่รู้จะแก้ยังไงให้ตรงละ
    unit2: '   ผล',
    asset1: Image.asset(
      'assets/images/OnePieceOfApple.jpg',
      height: 100,
      width: 100,
    ),
    asset2: Image.asset(
      'assets/images/Apple.png',
      height: 100,
      width: 100,
    ),
    format1: 90,
    format2: 300,
    limit: 350, //อย่าลบนะ
  );
  SmallWidget Swg2 = SmallWidget(
    total: 'รวม(มล.)',
    data: 'นม',
    unit1: 'แก้ว',
    unit2: 'กล่อง',
    asset1: Image.asset(
      'assets/images/glass_of_milk.png',
      height: 100,
      width: 100,
    ),
    asset2: Image.asset(
      'assets/images/Milk.png',
      height: 100,
      width: 100,
    ),
    format1: 200,
    format2: 250,
    limit: 300,
  );
  String statusDiet = '';
  Weight({Key? key, required String title, required this.navigateBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     print(Bwg.getRLdataMeat());
      //     print(Bwg.getRLdataRice());
      //     print(Bwg.getRLdataVeget());
      //     print(Swg1.getRLSmallWidget());
      //     print("All = " + Bwg.getAllWidgetData().toString());
      //   },
      //   label: Text(
      //     'Confirm',
      //     style: TextStyle(
      //       fontSize: 20,
      //       fontFamily: 'Twist',
      //       shadows: [
      //         BoxShadow(
      //           color: Colors.black,
      //           offset: Offset(2, 2),
      //           spreadRadius: 10,
      //         )
      //       ],
      //     ),
      //   ),
      //   backgroundColor: Color(0xffeeaeca),
      // ),
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: false,
          floating: false,
          expandedHeight: 200,
          shadowColor: Colors.black,
          backgroundColor: Color(0xffeeaeca),
          leading: IconButton(
            onPressed: navigateBack,
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              shadows: [
                BoxShadow(color: Colors.black, offset: Offset(5, 5), spreadRadius: 10, blurRadius: 10)
              ],
            ),
          ),
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.history,
                              color: Colors.black,
                            ),
                            Text(
                              '\tประวัติ',
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                        value: 'ประวัติ',
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(
                              Icons.question_mark_outlined,
                              color: Colors.black,
                            ),
                            Text(
                              '\tช่วยเหลือ',
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                        value: 'ช่วยเหลือ',
                      ),
                    ],
                onSelected: (value) {
                  if (value == 'ประวัติ') {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => History()));
                  } else if (value == 'ช่วยเหลือ') {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 400,
                            child: PageView(
                              children: [
                                Container(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/help1.jpg',
                                          height: 350,
                                        ),
                                        Text('ปัดหน้าจอเพื่อดูหน้าถัดไป'),
                                      ],
                                    ),
                                  ),
                                ),
                                //ใส่หน้าเพิ่มตรงนี้
                                Container(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/help2.jpg',
                                          height: 350,
                                        ),
                                        Text('ปัดหน้าจอเพื่อดูหน้าถัดไป'),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/help3.jpg',
                                          height: 350,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "เข้าใจแล้ว",
                                            style: TextStyle(color: Colors.black, fontSize: 18),
                                          ),
                                          style: ElevatedButton.styleFrom(backgroundColor: Color(0xffeeaeca), elevation: 8),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  }
                })
          ],
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => History()));
          //       },
          //       icon: Icon(
          //         Icons.history,
          //         size: 30,
          //         shadows: [
          //           BoxShadow(
          //               color: Colors.black,
          //               offset: Offset(5, 5),
          //               spreadRadius: 10,
          //               blurRadius: 10)
          //         ],
          //       ))
          // ],
          flexibleSpace: FlexibleSpaceBar(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'อาหารจานสุขภาพ',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Prompt',
                    shadows: [
                      BoxShadow(color: Colors.black, offset: Offset(5, 5), spreadRadius: 10, blurRadius: 10)
                    ],
                  ),
                ),
                Text(
                  "Healthy Diet",
                  style: TextStyle(
                    fontFamily: 'Itim',
                    fontSize: 16,
                    color: Colors.white,
                    shadows: [
                      BoxShadow(color: Colors.black, offset: Offset(2, 2), spreadRadius: 10, blurRadius: 10)
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            background: Container(
              foregroundDecoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Image.asset(
                    'assets/images/healthy_food.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
            padding: EdgeInsets.all(10.0),
            sliver: SliverList(
                delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 20,
                ),
                Bwg,
                SizedBox(
                  height: 20,
                ),
                Swg1,
                SizedBox(
                  height: 20,
                ),
                Swg2,
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (Bwg.getStatusBigWidget() == 'GOOD' && (Swg1.percentOut <= 1 || Swg1.percentOut >= 0.6) && (Swg2.percentOut == 1 || Swg2.percentOut >= 0.6)) {
                        statusDiet = "คุณกินได้ดีเยี่ยม";
                      } else {
                        statusDiet = "การกินยังไม่เหมาะสม";
                      }
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('บันทึกข้อมูลเรียบร้อย'),
                        action: SnackBarAction(
                          label: 'ประวัติ',
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => History()));
                          },
                        ),
                      ));
                      //เตรียมข้อมูล
                      transections statement = transections(dataMeat: Bwg.getRLdataMeat(), dataRice: Bwg.getRLdataRice(), dataVeget: Bwg.getRLdataVeget(), dataFruit: Swg1.getRLSmallWidget(), dataMilk: Swg2.getRLSmallWidget(), date: DateTime.now(), status: statusDiet);

                      //เรียก Provider
                      var provider = Provider.of<TransectionProvider>(context, listen: false);
                      provider.addTransection(statement);

                      print(Bwg.getRLdataMeat());
                      print(Bwg.getRLdataRice());
                      print(Bwg.getRLdataVeget());
                      print(Swg1.getRLSmallWidget());
                      print(Swg2.getRLSmallWidget());
                      print(statusDiet);
                      print("Confirm");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff94bbe9),
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        fontFamily: 'Itim',
                        fontSize: 32,
                        color: Colors.black,
                        shadows: [
                          BoxShadow(color: Colors.white, offset: Offset(2, 2), spreadRadius: 10, blurRadius: 10)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )))
      ]),
    );
  }
}
