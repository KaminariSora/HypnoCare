// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:project/helpScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodItem {
  final String name;
  final double sodium;

  FoodItem({required this.name, required this.sodium});

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      name: json['name'],
      sodium: json['sodium'].toDouble(),
    );
  }
}

class NaaState extends State<Naa> {
  double sodium = 2000;
  double sumSodium = 0;
  double perSo = 0;

  @override
  void initState() {
    super.initState();
    calculateSumSodium();
  }

  void calculateSumSodium() {
    sumSodium = widget.selectedFoods.fold(0, (total, foodItem) => total + foodItem.sodium);
  }

  @override
  Widget build(BuildContext context) {
    Color progressColor;
    double percent = perSodium();

    if (percent >= 0.8) {
      progressColor = Colors.red;
    } else if (percent >= 0.5) {
      progressColor = Colors.yellow;
    } else {
      progressColor = Colors.green;
    }

    return SizedBox(
      height: 300,
      child: CircularPercentIndicator(
        radius: 120.0,
        lineWidth: 24.0,
        percent: percent,
        center: Text(
          '${(percent * 100).toStringAsFixed(0)}%',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        progressColor: progressColor,
      ),
    );
  }

  double perSodium() {
    perSo = (sumSodium / sodium);
    return perSo;
  }

  @override
  void didUpdateWidget(covariant Naa oldWidget) {
    super.didUpdateWidget(oldWidget);
    calculateSumSodium();
  }
}

class SodiumTrackerApp extends StatefulWidget {
  const SodiumTrackerApp({Key? key}) : super(key: key);

  @override
  SodiumTrackerAppState createState() => SodiumTrackerAppState();
}

class SodiumTrackerAppState extends State<SodiumTrackerApp> {
  String searchQuery = '';
  List<FoodItem> availableFoods = [];
  List<FoodItem> selectedFoods = [];
  int totalSodium = 0;

  @override
  void initState() {
    super.initState();
    loadFoodItems();
  }

  Future<void> loadFoodItems() async {
    String jsonData = await rootBundle.loadString('assets/food_data.json');
    List<dynamic> jsonList = json.decode(jsonData);

    setState(() {
      availableFoods = jsonList.map((item) => FoodItem.fromJson(item)).toList();
    });
  }

  void _onFoodItemSelected(FoodItem foodItem, bool selected) {
    setState(() {
      if (selected) {
        selectedFoods.add(foodItem);
        totalSodium += foodItem.sodium.toInt();
      } else {
        selectedFoods.remove(foodItem);
        totalSodium -= foodItem.sodium.toInt();
      }

      saveSodiumHistory(selectedFoods);
    });
  }

  void saveSodiumHistory(List<FoodItem> selectedFoods) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('sodiumHistory');

    DateTime now = DateTime.now();
    String currentDate = '${now.day}/${now.month}/${now.year}';
    List<String> history = prefs.getStringList('sodiumHistory') ?? [];

    history.clear();
    for (FoodItem foodItem in selectedFoods) {
      String entry = '$currentDate: ${foodItem.name} - ${foodItem.sodium} mg';
      history.add(entry);
    }

    await prefs.setStringList('sodiumHistory', history);
  }

  @override
  Widget build(BuildContext context) {
    List<FoodItem> filteredFoods = availableFoods.where((foodItem) {
      final nameLower = foodItem.name.toLowerCase();
      final queryLower = searchQuery.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    return MaterialApp(
      title: 'Sodium Tracker',
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Daily sodium intake",
            style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'Itim'),
          ),
          centerTitle: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                Color(0xffeeaeca),
                Color(0xff94bbe9)
              ]),
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
                    navigateToHistoryPage();
                  } else if (value == 'ช่วยเหลือ') {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 330,
                            child: PageView(
                              children: [
                                HelpScreen(asset: Image.asset('assets/images/helpSodium1.jpg')),
                                HelpScreen(asset: Image.asset('assets/images/helpSodium2.jpg')),
                                HelpScreen(asset: Image.asset('assets/images/helpSodium3.jpg')),
                                HelpScreen(asset: Image.asset('assets/images/helpSodium4.jpg')),
                                Container(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Image.asset('assets/images/helpSodium5.jpg'),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "เข้าใจแล้ว",
                                            style: TextStyle(color: Colors.black, fontSize: 18),
                                          ),
                                          style: ElevatedButton.styleFrom(backgroundColor: Color(0xffeeaeca), elevation: 8),
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
                })
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back when the button is pressed
            },
          ),
        ),
        body: Column(
          children: [
            Naa(selectedFoods: selectedFoods),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredFoods.length,
                itemBuilder: (context, index) {
                  final foodItem = filteredFoods[index];
                  final isSelected = selectedFoods.contains(foodItem);
                  return ListTile(
                    title: Text(foodItem.name),
                    subtitle: Text('Sodium: ${foodItem.sodium} mg'),
                    trailing: Text(
                      isSelected ? 'Selected' : '',
                      style: const TextStyle(color: Colors.green),
                    ),
                    onTap: () {
                      if (isSelected) {
                        _onFoodItemSelected(foodItem, false);
                      } else {
                        if (totalSodium + foodItem.sodium <= 2000) {
                          _onFoodItemSelected(foodItem, true);
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('คำเตือน!!!'),
                                content: const Text(
                                  'ปริมาณโซเดียมไม่ควรเกิน 2000 มิลลิกรัมต่อวัน',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.grey[200],
                child: Text(
                  'Total Sodium: $totalSodium mg',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: confirmSelection,
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
            ),
          ],
        ),
      ),
    );
  }

  void navigateToHistoryPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryPage(
          selectedFoods: selectedFoods,
          totalSodium: totalSodium,
        ),
      ),
    );
  }

  void confirmSelection() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Selection'),
          content: Text(
            'ต้องการยืนยันเมนูที่เลือกใช่ไหม\nTotal Sodium: $totalSodium mg',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

class HistoryPage extends StatelessWidget {
  final List<FoodItem> selectedFoods;
  final int totalSodium;

  const HistoryPage({
    Key? key,
    required this.selectedFoods,
    required this.totalSodium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sodium Consumption",
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle the back button press
            // Add your desired functionality here
            print('Back button pressed');
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: getSodiumHistory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<String> history = snapshot.data!;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(history[index]),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    clearSodiumHistory();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('History cleared')),
                    );
                  },
                  child: const Text(
                    'Clear History',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void clearSodiumHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('sodiumHistory');
  }

  int calculateTotalSodium(List<String> history) {
    int totalSodium = 0;

    for (String entry in history) {
      int sodiumIndex = entry.lastIndexOf('-') + 1;
      int sodium = int.tryParse(entry.substring(sodiumIndex, entry.length - 3).trim()) ?? 0;
      totalSodium += sodium;
    }

    return totalSodium;
  }
}

Future<List<String>> getSodiumHistory() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('sodiumHistory') ?? [];
}

class Naa extends StatefulWidget {
  final List<FoodItem> selectedFoods;

  const Naa({Key? key, required this.selectedFoods}) : super(key: key);

  @override
  NaaState createState() => NaaState();
}
