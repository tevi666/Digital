import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'global_text.dart';

class GlobalButton extends StatefulWidget {
  const GlobalButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.color,
    required this.size,
    this.maskFormatter, this.smsCodeDescription, required this.bg,
  }) : super(key: key);

  final Function() onPressed;
  final String title;
  final Color color;
  final Color bg;
  final double size;
  final MaskTextInputFormatter? maskFormatter;
  final String? smsCodeDescription; 

  @override
  State<GlobalButton> createState() => _GlobalButtonState();
}

class _GlobalButtonState extends State<GlobalButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: widget.bg,
      ),
      onPressed: widget.onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 68, vertical: 16),
        child: GlobalText(
          text: widget.title,
          color: widget.color,
          size: widget.size,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
