import 'package:flutter/material.dart';

class RowLineText extends StatefulWidget {
  final String externalData;

  const RowLineText({Key? key, required this.externalData}) : super(key: key);

  @override
  State<RowLineText> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RowLineText> {
  String internalData = '';

  @override
  void didUpdateWidget(RowLineText oldWidget) {
    if (oldWidget.externalData != widget.externalData) {
      setState(() {
        internalData = widget.externalData;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    internalData = widget.externalData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        internalData.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          height: 1.5,
          color: Colors.black,
        ),
      ),
    );
  }
}
