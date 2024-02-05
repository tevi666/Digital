// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class AuthLogic {
//   late int timer;
//   TextEditingController phoneController = TextEditingController();

//   TextEditingController otpController = TextEditingController();

//   FirebaseAuth auth = FirebaseAuth.instance;

//   bool otpVisibility = false;

//   String verificationID = "";

//   AuthLogic() {
//     timer = 0;
//   }

//   void startTimer() {
//     const oneSec = Duration(seconds: 1);

//     Timer.periodic(oneSec, (Timer timer) {
//       if (this.timer > 0) {
//         this.timer--;
//       } else {
//         timer.cancel();
//       }
//     });
//   }


// String formatPhoneNumber(String phoneNumber) {
//   String cleaned = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
//   if (!cleaned.startsWith('+')) {
//     cleaned = '+$cleaned';
//   }

//   return cleaned;
// }


//   void loginWithPhone() async {
//     String formattedPhoneNumber = formatPhoneNumber(phoneController.text);
//     print("Phone number to verify: $formattedPhoneNumber");
//     auth.verifyPhoneNumber(
//       phoneNumber: formattedPhoneNumber,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await auth.signInWithCredential(credential).then((value) {
//           print("You are logged in successfully");
//         });
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         print(e.message);
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         otpVisibility = true;
//         verificationID = verificationId;
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }

//   void verifyOTP() async {
//     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationID, smsCode: otpController.text);

//     await auth.signInWithCredential(credential).then((value) {
//       print("You are logged in successfully");
//       Fluttertoast.showToast(
//           msg: "You are logged in successfully",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0);
//     });
//   }
// }
