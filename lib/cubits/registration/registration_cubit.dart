// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sobol_digital/cubits/registration/registration_state.dart';

// class RegistrationCubit extends Cubit<RegistrationState> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   RegistrationCubit() : super(RegistrationInitial());

//   Future<void> sendOTP(String phoneNumber) async {
//     emit(RegistrationLoading());

//     try {
//       await _auth.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           emit(RegistrationError(message: 'Verification Failed: ${e.message}'));
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           emit(RegistrationCodeSent(verificationId: verificationId));
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//         },
//       );
//     } catch (e) {
//       emit(RegistrationError(message: 'Error: $e'));
//     }
//   }
// }


// class RegistrationCodeSent extends RegistrationState {
//   final String verificationId;

//   RegistrationCodeSent({
//     required this.verificationId,
//   });
// }