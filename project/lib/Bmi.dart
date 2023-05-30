import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/model/Mbmi.dart';
import 'package:project/providers/bmi_provider.dart';
import 'package:project/history_screen.dart';
import 'helpScreen.dart';

class Bmi extends StatefulWidget {
  const Bmi({Key? key}) : super(key: key);

  @override
  State<Bmi> createState() => _BmiState();
}

class _BmiState extends State<Bmi> {
  final _heightControl = TextEditingController();
  final _weightControl = TextEditingController();

  final nnbimControl = TextEditingController();
  final mmessControl = TextEditingController();

  double? _bmi;
  String _message = " ";
  Widget? pho;
  String __ = " ";

  @override
  void initState() {
    super.initState();
    Provider.of<BmiProvider>(context, listen: false).initData();
  }

  void _calculate() {
    final double? height = double.tryParse(_heightControl.value.text);
    final double? weight = double.tryParse(_weightControl.value.text);

    if (height == null ||
        height <= 0 ||
        weight == null ||
        weight <= 0 ||
        height >= 10) {
      setState(() {
        _bmi = null;
        _message = "ต้องมีอะไรผิดพลาดตรงไหน\nป้อนข้อมูลใหม่^^";
        pho = picturex();
      });
    } else {
      setState(() {
        _bmi = weight / (height * height);

        if (_bmi! < 18.5) {
          _message = "คุณผอมเกินไป \nควรเพิ่มน้ำหนักสักหน่อย";
          pho = picturep();
        } else if (_bmi! < 25) {
          _message = "คุณมีร่างกายที่สมดุลแล้ว \nสุดยอดไปเลย";
          pho = pictureh();
        } else if (_bmi! < 30) {
          _message = "คุณเริ่มท้วมไปแล้วนะ \nควรลดน้ำหนักสักหน่อย";
          pho = picturet();
        } else {
          _message = "คุณอ้วนแล้วนะ \nควรลดน้ำหนัก";
          pho = picturef();
        }
      });

      final nnbimControl = _bmi!.toStringAsFixed(2);
      final mmessControl = _message;

      var nnbmi = nnbimControl;
      var mmess = mmessControl;

      Mbmi statement =
          Mbmi(mess: mmess, nbmi: double.parse(nnbmi), date: DateTime.now());

      var provider = Provider.of<BmiProvider>(context, listen: false);
      provider.addMbmi(statement);
    }
  }

  void _history() {
    setState(() {
      _bmi = null;
      _message = " ";
      pho = null;
    });

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HistoryScreen();
    }));
  }

  Widget picturex() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('assets/images/x.jpg'),
    );
  }

  Widget picturet() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('assets/images/t.jpg'),
    );
  }

  Widget picturep() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('assets/images/p.jpg'),
    );
  }

  Widget pictureh() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('assets/images/h.png'),
    );
  }

  Widget picturef() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('assets/images/f.jpg'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Body Mass Index",
            style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Itim'),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xffeeaeca), Color(0xff94bbe9)]),
            ),
          ),
          actions: <Widget>[
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HistoryScreen()));
                  } else if (value == 'ช่วยเหลือ') {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 340,
                            child: PageView(
                              children: [
                                HelpScreen(
                                    asset: Image.asset(
                                        'assets/images/helpBMI1.jpg')),
                                HelpScreen(
                                    asset: Image.asset(
                                        'assets/images/helpBMI2.jpg')),
                                HelpScreen(
                                    asset: Image.asset(
                                        'assets/images/helpBMI3.jpg')),
                                Container(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                            'assets/images/helpBMI4.jpg'),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "เข้าใจแล้ว",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color(0xffeeaeca),
                                              elevation: 8),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  }
                }
                // Padding(
                //     padding: EdgeInsets.only(right: 20.0),
                //     child: GestureDetector(
                //       onTap: () {
                //         _history();
                //       },
                //       child: Icon(
                //         Icons.history,
                //         size: 26.0,
                //       ),
                //     )),
                )
          ]),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 320,
            child: Card(
              color: Colors.white,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "BMI",
                      textAlign: TextAlign.center,
                    ),
                    TextField(
                      decoration:
                          InputDecoration(labelText: "น้ำหนัก(กิโลกรัม)"),
                      keyboardType: TextInputType.number,
                      controller: _weightControl,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: "ส่วนสูง(เมตร)"),
                      keyboardType: TextInputType.number,
                      controller: _heightControl,
                    ),
                    Text(
                      __,
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: _calculate,
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xff94bbe9).withOpacity(0.8)),
                      child: const Text(
                        'Calculate...',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    Text(
                      _bmi == null ? '' : _bmi!.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      width: 120.0,
                      height: 120.0,
                      child: pho,
                    ),
                    Text(
                      _message,
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
