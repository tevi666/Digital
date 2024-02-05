import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../utilities/constants/app_colors.dart';

class GlobalPinFieldAutoFill extends StatefulWidget {
  const GlobalPinFieldAutoFill({
    Key? key,
    required this.otpController,
    required this.loginWithPhone,
    required this.verifyOTP, required this.onChanged,
  }) : super(key: key);

  final TextEditingController otpController;
  final void Function(String) loginWithPhone;
  final Function verifyOTP;
  final Function onChanged;

  @override
  State<GlobalPinFieldAutoFill> createState() => _GlobalPinFieldAutoFillState();
}

class _GlobalPinFieldAutoFillState extends State<GlobalPinFieldAutoFill> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Platform.isAndroid
          ? Pinput(
              androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
              controller: widget.otpController,
              length: 6,
              onCompleted: (String value) {
                widget.loginWithPhone(value);
              },
              onChanged: (v) => widget.onChanged(v)
            )
          : PinFieldAutoFill(
              controller: widget.otpController,
              autoFocus: true,
              decoration: UnderlineDecoration(
                colorBuilder: const FixedColorBuilder(AppColors.inactiveButton),
                textStyle: TextStyle(fontSize: 18, color: Colors.black),
              ),
              onCodeSubmitted: (code) {
                widget.loginWithPhone(code);
              },
              onCodeChanged: (code) {},
              codeLength: 6,
            ),
    );
  }
}
