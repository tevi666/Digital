import 'package:sms_autofill/sms_autofill.dart';

import '../registration.dart';

class RegistrationContent extends StatefulWidget {
  const RegistrationContent({
    Key? key,
    required this.inputController,
    required this.isButtonEnabled,
    required this.maskFormatter,
    required this.currentStep,
    required this.onCompleteStep,
    required this.smsCodeDescription,
    required this.phoneNumber,
    required this.inputControllerName,
    required this.inputControllerSurname,
  }) : super(key: key);

  final TextEditingController inputController;
  final TextEditingController inputControllerName;
  final TextEditingController inputControllerSurname;
  final bool isButtonEnabled;
  final MaskTextInputFormatter maskFormatter;
  final int currentStep;
  final VoidCallback onCompleteStep;
  final String smsCodeDescription;
  final String phoneNumber;

  @override
  State<RegistrationContent> createState() => _RegistrationContentState();
}

class _RegistrationContentState extends State<RegistrationContent> {
  late int timer;
  PageController pageController = PageController();
  // late AuthLogic authLogic;

  // TextEditingController phoneController =
  //     TextEditingController(text: '+1(555) 123-45-67');
  // TextEditingController otpController = TextEditingController();

  // FirebaseAuth auth = FirebaseAuth.instance;

  // bool otpVisibility = false;

  // String verificationID = "";

  @override
  void initState() {
    super.initState();
    timer = 0;
    // authLogic = AuthLogic();
  }

  @override
  Widget build(BuildContext context) {
    UserInfoProvider userInfoProvider = Provider.of<UserInfoProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GlobalText(
          text: _getRegistrationText(widget.currentStep),
          color: AppColors.text,
          size: 34,
          fontWeight: FontWeight.w900,
        ),
        AppSizedBox.t24,
        SizedBox(
          width: widget.currentStep == 2 ? 280 : 200,
          child: GlobalText(
            text: _getStepText(widget.currentStep),
            color: AppColors.text,
            size: 14,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
          ),
        ),
        AppSizedBox.t38,
        if (widget.currentStep == 2)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55),
                child: Platform.isAndroid ? Pinput(
                  length: 6,
                  onChanged: (code) => {
                    if (code.length == 6) {
                        widget.onCompleteStep()
                      }
                  },
                ) : PinFieldAutoFill(
                  autoFocus: true,
                  decoration: UnderlineDecoration(
                    colorBuilder: const FixedColorBuilder(AppColors.inactiveButton),
                    textStyle: const TextStyle(fontSize: 18, color: AppColors.text),
                  ),
                  onCodeSubmitted: (code) {
                  },
                  onCodeChanged: (code) {
                      if (code!.length == 6) {
                        widget.onCompleteStep();
                      }
                  },
                  codeLength: 6,
                ),
              ),
              AppSizedBox.t45,
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return GestureDetector(
                    onTap: () {
                      if (timer == 0) {
                        const oneSec = Duration(seconds: 1);
                        Timer.periodic(oneSec, (Timer timer) {
                          setState(() {
                            if (this.timer >= 1) {
                              this.timer--;
                            } else {
                              timer.cancel();
                            }
                          });
                        });
                        timer = 60;
                      }
                    },
                    child: GlobalText(
                      text: timer == 0
                          ? 'Отправить код еще раз'
                          : '$timer сек до повтора отправки кода',
                      color: timer == 0 ? AppColors.gold : AppColors.text,
                      size: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                },
              ),
            ],
          ),
        if (widget.currentStep == 1)
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16, bottom: 5),
              child: GlobalText(
                text: 'Номер телефона',
                color: AppColors.text,
                size: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        if (widget.currentStep == 3)
          Column(
            children: [
              const Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 5),
                  child: GlobalText(
                    text: 'Имя',
                    color: AppColors.text,
                    size: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GlobalInput(
                    controller: widget.inputControllerName,
                    onChanged: (value) {},
                    keyboardType: TextInputType.name),
              ),
              AppSizedBox.t8,
              const Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 5),
                  child: GlobalText(
                    text: 'Фамилия',
                    color: AppColors.text,
                    size: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GlobalInput(
                  controller: widget.inputControllerSurname,
                  onChanged: (value) {},
                  keyboardType: TextInputType.name,
                ),
              ),
              AppSizedBox.t24,
              GlobalButton(
                onPressed: () {
                  userInfoProvider
                      .updateFirstName(widget.inputControllerName.text);
                  userInfoProvider
                      .updateLastName(widget.inputControllerSurname.text);
                  return Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccountPage()));
                },
                title: 'Сохранить',
                color: AppColors.text,
                size: 16,
                bg: (widget.inputControllerName.text.length >= 2 &&
                        widget.inputControllerSurname.text.length >= 2)
                    ? AppColors.gold
                    : AppColors.inactiveButton,
              ),
            ],
          ),
        if (widget.currentStep == 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GlobalInput(
              inputFormatters: [widget.maskFormatter],
              controller: widget.inputController,
              onChanged: (v) {},
              keyboardType: TextInputType.phone,
            ),
          ),
        AppSizedBox.t120,
        widget.currentStep > 1
            ? const SizedBox()
            : GlobalButton(
                onPressed: () {
                  if (widget.maskFormatter.isFill()) {
                    widget.onCompleteStep();
                  }
                },
                title: 'Отправить смс-код',
                color: AppColors.text,
                size: 16,
                maskFormatter: widget.maskFormatter,
                smsCodeDescription: widget.smsCodeDescription,
                bg: widget.maskFormatter.isFill()
                    ? AppColors.gold
                    : AppColors.inactiveButton,
              ),
        AppSizedBox.t8,
        widget.currentStep > 1 ? const SizedBox() : const PersonalInfoText(),
      ],
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);

    Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (this.timer > 0) {
          this.timer--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  String _getRegistrationText(int step) {
    if (step == 1) {
      return 'Регистрация';
    } else if (step == 2) {
      return 'Подтверждение';
    } else {
      return 'Регистрация';
    }
  }

  String _getStepText(int step) {
    if (step == 1) {
      return 'Введите номер телефона для регистрации';
    } else if (step == 2) {
      return 'Введите код, который мы отправили в SMS на ${widget.phoneNumber}';
    } else {
      return '';
    }
  }

  // String formatPhoneNumber(String phoneNumber) {
  //   String cleaned = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

  //   if (!cleaned.startsWith('+')) {
  //     cleaned = '+$cleaned';
  //   }

  //   return cleaned;
  // }

  // void loginWithPhone() async {
  //   // Форматируем введенный номер телефона
  //   String formattedPhoneNumber = formatPhoneNumber(phoneController.text);
  //   print(formattedPhoneNumber);
  //   try {
  //     await auth.verifyPhoneNumber(
  //       phoneNumber: formattedPhoneNumber,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await auth.signInWithCredential(credential).then((value) {
  //           widget.onCompleteStep();
  //           print("You are logged in successfully");
  //         });
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         print(e.message);
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //         otpVisibility = true;
  //         verificationID = verificationId;
  //         setState(() {});
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {},
  //     );
  //   } catch (e) {
  //     print("Error during phone verification: $e");
  //   }
  // }

  // void verifyOTP() async {
  //   try {
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: verificationID, smsCode: otpController.text);

  //     UserCredential authResult = await auth.signInWithCredential(credential);

  //     if (authResult.user != null) {
  //       print("You are logged in successfully");
  //       Fluttertoast.showToast(
  //           msg: "You are logged in successfully",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.green,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //     } else {
  //       print("Failed to log in");
  //       Fluttertoast.showToast(
  //           msg: "Failed to log in",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.red,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //     }
  //   } catch (e) {
  //     print("Error during phone verification: $e");
  //     Fluttertoast.showToast(
  //         msg: "Error during phone verification: $e",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  // }
}
