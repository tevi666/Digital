import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'registration.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  int _currentStep = 1;
  bool _isCompleted1 = false;
  bool _isCompleted2 = false;
  bool _isCompleted3 = false;
  TextEditingController inputController = TextEditingController();
  bool isButtonEnabled = false;
  final PageController _pageController = PageController(initialPage: 0);
  String smsCodeDescription = '';
  TextEditingController inputControllerName = TextEditingController();
  TextEditingController inputControllerSurname = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  var maskFormatter = MaskTextInputFormatter(
    mask: '+# (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isPhoneNumberFilled = false;
  bool otpVisibility = false;
  late int timer;
  String verificationID = "";

  @override
  void initState() {
    timer = 0;
    inputController.addListener(() {
      setState(() {
        isButtonEnabled = inputController.text.isNotEmpty;
      });
    });
    inputControllerName.addListener(() {
      setState(() {
        isButtonEnabled = inputControllerName.text.isNotEmpty;
      });
    });
    inputControllerSurname.addListener(() {
      setState(() {
        isButtonEnabled = inputControllerSurname.text.isNotEmpty;
      });
    });
    inputController.addListener(() {
      setState(() {
        isButtonEnabled = inputController.text.isNotEmpty;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserInfoProvider userInfoProvider = Provider.of<UserInfoProvider>(context);
    MaskTextInputFormatter ms = MaskTextInputFormatter();

    return Scaffold(
      appBar: AppBar(
        leading: _currentStep != 1
            ? GlobalIcon(
                icons: Icons.arrow_back_ios_new,
                size: 20,
                color: _currentStep == 3 ? AppColors.gold : AppColors.text,
                onTap: () => {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      if (_currentStep > 1)
                        {
                          setState(() {
                            _currentStep--;
                          })
                        }
                    })
            : null,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 200,
                child: Stack(
                  children: [
                    CustomPaint(
                      painter: LinePainter(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Indicator(
                            isCompleted: _isCompleted1,
                            isActive: _currentStep == 1,
                            child: Center(
                              child: _isCompleted1
                                  ? GlobalIcon(
                                      icons: Icons.check,
                                      size: 24,
                                      color: AppColors.check,
                                      onTap: () {},
                                    )
                                  : const GlobalText(
                                      text: '1',
                                      color: AppColors.indicatorNum,
                                      size: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                            ),
                          ),
                          Indicator(
                            isCompleted: _isCompleted2,
                            isActive: _currentStep == 2,
                            child: Center(
                              child: _isCompleted2
                                  ? GlobalIcon(
                                      icons: Icons.check,
                                      size: 24,
                                      color: AppColors.check,
                                      onTap: () {},
                                    )
                                  : const GlobalText(
                                      text: '2',
                                      color: AppColors.indicatorNum,
                                      size: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                            ),
                          ),
                          Indicator(
                            isCompleted: _isCompleted3,
                            isActive: _currentStep == 3,
                            child: Center(
                              child: _isCompleted3
                                  ? GlobalIcon(
                                      icons: Icons.check,
                                      size: 24,
                                      color: AppColors.check,
                                      onTap: () {
                                        _pageController.previousPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                    )
                                  : const GlobalText(
                                      text: '3',
                                      color: AppColors.indicatorNum,
                                      size: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppSizedBox.t24,
            ExpandablePageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              itemCount: 3,
              itemBuilder: ((context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GlobalText(
                      text: _getRegistrationText(_currentStep),
                      color: AppColors.text,
                      size: 34,
                      fontWeight: FontWeight.w900,
                    ),
                    AppSizedBox.t24,
                    SizedBox(
                      width: _currentStep == 2 ? 280 : 200,
                      child: GlobalText(
                        text: _getStepText(_currentStep),
                        color: AppColors.text,
                        size: 14,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    AppSizedBox.t38,
                    if (_currentStep == 2)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 55),
                            child: Platform.isAndroid
                                ? Pinput(
                                    controller: otpController,
                                    length: 6,
                                    onChanged: (code) => {
                                      if (code.length == 6) {verifyOTP()}
                                    },
                                  )
                                : PinFieldAutoFill(
                                    controller: otpController,
                                    autoFocus: true,
                                    decoration: UnderlineDecoration(
                                      colorBuilder: const FixedColorBuilder(
                                          AppColors.inactiveButton),
                                      textStyle: const TextStyle(
                                          fontSize: 18, color: AppColors.text),
                                    ),
                                    onCodeSubmitted: (code) {},
                                    onCodeChanged: (code) {
                                      if (code!.length == 6) {
                                        verifyOTP();
                                      }
                                    },
                                    codeLength: 6,
                                  ),
                          ),
                          AppSizedBox.t45,
                          StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
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
                                  color: timer == 0
                                      ? AppColors.gold
                                      : AppColors.text,
                                  size: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    if (_currentStep == 1)
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
                    if (_currentStep == 3)
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
                                controller: inputControllerName,
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
                              controller: inputControllerSurname,
                              onChanged: (value) {},
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          AppSizedBox.t24,
                          GlobalButton(
                            onPressed: () {
                              userInfoProvider
                                  .updateFirstName(inputControllerName.text);
                              userInfoProvider
                                  .updateLastName(inputControllerSurname.text);
                              return Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AccountPage()));
                            },
                            title: 'Сохранить',
                            color: AppColors.text,
                            size: 16,
                            bg: (inputControllerName.text.length >= 2 &&
                                    inputControllerSurname.text.length >= 2)
                                ? AppColors.gold
                                : AppColors.inactiveButton,
                          ),
                        ],
                      ),
                    if (_currentStep == 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GlobalInput(
                          inputFormatters: [maskFormatter],
                          controller: phoneController,
                          onChanged: (v) {
                            setState(() {
                              isPhoneNumberFilled = v.length == maskFormatter.getMask()!.length;
                            });
                          },
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    AppSizedBox.t120,
                    _currentStep > 1
                        ? const SizedBox()
                        : GlobalButton(
                            onPressed: () {
                              if (isPhoneNumberFilled) {
        loginWithPhone();
        Future.delayed(const Duration(seconds: 1), () {
          onCompletedStep();
        });
      }
                            },
                            title: 'Отправить смс-код',
                            color: AppColors.text,
                            size: 16,
                            maskFormatter: maskFormatter,
                            smsCodeDescription: smsCodeDescription,
                            bg: isPhoneNumberFilled ? AppColors.gold : AppColors.inactiveButton

                            ),

                    AppSizedBox.t8,
                    _currentStep > 1
                        ? const SizedBox()
                        : const PersonalInfoText(),
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  void onCompletedStep() {
    setState(() {
      if (_currentStep == 1) {
        _isCompleted1 = true;
      } else if (_currentStep == 2) {
        _isCompleted2 = true;
      } else if (_currentStep == 3) {
        _isCompleted3 = true;
      }

      _currentStep = (_currentStep % 3) + 1;
      _pageController.animateToPage(_currentStep - 1,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
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
      return 'Введите код, который мы отправили в SMS на ${phoneController.text}';
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
      verificationId: verificationID,
      smsCode: otpController.text,
    );

    try {
      // Попытка верификации кода
      await auth.signInWithCredential(credential);
      // Если код верифицирован успешно, вызывается метод onCompletedStep()
      onCompletedStep();
      print("You are logged in successfully");
      Fluttertoast.showToast(
        msg: "You are logged in successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (error) {
      // Если произошла ошибка при верификации кода, выводится сообщение об ошибке
      print("Error verifying OTP: $error");
      Fluttertoast.showToast(
        msg: "Not Right Code",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
