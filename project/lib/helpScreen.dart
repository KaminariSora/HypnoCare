import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  final Image asset;
  const HelpScreen({super.key,required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            asset,
            Text('ปัดหน้าจอเพื่อดูหน้าถัดไป'),
          ],
        ),
      ),
    );
  }
}
