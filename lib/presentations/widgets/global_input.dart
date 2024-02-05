import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utilities/constants/app_colors.dart';

class GlobalInput extends StatefulWidget {
  const GlobalInput(
      {Key? key,
      required this.controller,
      this.inputFormatters,
      required this.onChanged, this.keyboardType})
      : super(key: key);

  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;

  @override
  _GlobalInputState createState() => _GlobalInputState();
}

class _GlobalInputState extends State<GlobalInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboardType,
      cursorColor: AppColors.cursor,
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.gold),
        ),
      ),
      onChanged: widget.onChanged,
    );
  }
}
