import 'package:flutter/material.dart';

class GlobalText extends StatelessWidget {
  const GlobalText({super.key, required this.text, required this.color, required this.size, required this.fontWeight, this.textAlign = TextAlign.start});
  final String text;
  final Color color;
  final double size;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight), textAlign: textAlign);
  }
}
