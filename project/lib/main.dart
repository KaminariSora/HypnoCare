import 'package:flutter/material.dart';
import 'MainScreen.dart';
import 'package:project/providers/bmi_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) {
            return BmiProvider();
          }),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "HypnoCare",
          home: MainScreen(),
          theme: ThemeData(
              // Use the fontFamily property of the TextStyle object
              fontFamily: 'Prompt'),
        ));
  }
}
