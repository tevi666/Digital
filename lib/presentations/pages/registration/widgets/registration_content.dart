import 'package:sms_autofill/sms_autofill.dart';

import '../registration.dart';

class RegistrationContent extends StatefulWidget {
  const RegistrationContent(
      {super.key,
      required this.inputController,
      required this.inputControllerName,
      required this.inputControllerSurname,
      required this.isButtonEnabled,
      required this.maskFormatter,
      required this.currentStep,
      required this.onCompleteStep,
      required this.smsCodeDescription,
      required this.phoneNumber});

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
  _RegistrationContentState createState() => _RegistrationContentState();
}

class _RegistrationContentState extends State<RegistrationContent>
    with AutomaticKeepAliveClientMixin {
  late PageStorageKey _pageStorageKey;

  @override
  bool get wantKeepAlive => true;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  late int timer;
  PageController pageController = PageController();
  FirebaseAuth auth = FirebaseAuth.instance;

  bool otpVisibility = false;

  String verificationID = "";

  @override
  void initState() {
    super.initState();
    _pageStorageKey = PageStorageKey(widget.key);
    timer = 0;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                child: Platform.isAndroid
                    ? Pinput(
                        controller: otpController,
                        length: 6,
                        onChanged: (code) => {
                          verifyOTP(),
                          // if (code.length == 6) {widget.onCompleteStep()}
                        },
                      )
                    : PinFieldAutoFill(
                        controller: otpController,
                        autoFocus: true,
                        decoration: UnderlineDecoration(
                          colorBuilder:
                              const FixedColorBuilder(AppColors.inactiveButton),
                          textStyle: const TextStyle(
                              fontSize: 18, color: AppColors.text),
                        ),
                        onCodeSubmitted: (code) {},
                        onCodeChanged: (code) {
                          verifyOTP();
                          // if (code.length == 6) {
                          //   // widget.onCompleteStep();
                          // }
                        },
                        codeLength: 6,
                      ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (otpVisibility) {
                      verifyOTP();
                    } else {
                      loginWithPhone();
                    }
                  },
                  child: otpVisibility
                      ? Icon(Icons.abc)
                      : Icon(Icons.next_plan_outlined)),
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
              controller: phoneController,
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
                    loginWithPhone();
                    Future.delayed(const Duration(seconds: 1), () {
                      widget.onCompleteStep();
                    });
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
        // TextField(
        //   controller: phoneController,
        //   decoration: InputDecoration(labelText: "Phone number"),
        //   keyboardType: TextInputType.phone,
        // ),
        // Visibility(
        //   child: TextField(
        //     controller: otpController,
        //     decoration: InputDecoration(),
        //     keyboardType: TextInputType.number,
        //   ),
        //   visible: otpVisibility,
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // ElevatedButton(
        //     onPressed: () {
        //       if (otpVisibility) {
        //         verifyOTP();
        //       } else {
        //         loginWithPhone();
        //       }
        //     },
        //     child: Text(otpVisibility ? "Verify" : "Login")),
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

  String formatPhoneNumber(String phoneNumber) {
    String cleaned = phoneController.text.replaceAll(RegExp(r'[^\d+]'), '');

    if (!cleaned.startsWith('+')) {
      cleaned = '+$cleaned';
    }

    return cleaned;
  }

  void loginWithPhone() async {
    var formatted = formatPhoneNumber(phoneController.text);
    auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value) {
      print("You are logged in successfully");
      Fluttertoast.showToast(
          msg: "You are logged in successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}
