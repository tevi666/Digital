import 'package:expandable_page_view/expandable_page_view.dart';

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

  var maskFormatter = MaskTextInputFormatter(
    mask: '+# (###) ###-##-##',

    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void initState() {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                return RegistrationContent(
                  inputController: inputController,
                  isButtonEnabled: isButtonEnabled,
                  maskFormatter: maskFormatter,
                  currentStep: _currentStep,
                  onCompleteStep: () {
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
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    });
                  },
                  smsCodeDescription: smsCodeDescription,
                  phoneNumber: inputController.text, inputControllerName: inputControllerName, inputControllerSurname: inputControllerSurname,
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}


