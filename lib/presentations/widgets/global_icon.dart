import 'package:flutter/material.dart';

class GlobalIcon extends StatelessWidget {
  const GlobalIcon({super.key, required this.icons, required this.size, required this.color, required this.onTap});
  final IconData icons;
  final double size;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icons,
        size: size,
        color: color,
      ),
    );
  }
}
