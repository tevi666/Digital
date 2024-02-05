import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegistrationProvider with ChangeNotifier {
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
    mask: '+## (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );


  int get currentStep => _currentStep;
  bool get isCompleted1 => _isCompleted1;
  bool get isCompleted2 => _isCompleted2;
  bool get isCompleted3 => _isCompleted3;

  PageController get pageController => _pageController;

    set currentStep(int step) {
    _currentStep = step;
    notifyListeners();
  }

  void initializeListeners() {
    inputController.addListener(() {
      isButtonEnabled = inputController.text.isNotEmpty;
      notifyListeners();
    });

    inputControllerName.addListener(() {
      isButtonEnabled = inputControllerName.text.isNotEmpty;
      notifyListeners();
    });

    inputControllerSurname.addListener(() {
      isButtonEnabled = inputControllerSurname.text.isNotEmpty;
      notifyListeners();
    });
  }

void completeStep() {
  if (_currentStep == 1) {
    _isCompleted1 = true;
  } else if (_currentStep == 2) {
    _isCompleted2 = true;
  } else if (_currentStep == 3) {
    _isCompleted3 = true;
  }

  _currentStep = (_currentStep % 3) + 1;

  isButtonEnabled = false;
  inputController.clear();
  inputControllerName.clear();
  inputControllerSurname.clear();

  _pageController.animateToPage(
    _currentStep - 1,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );

  notifyListeners();
}


  @override
  void dispose() {
    inputController.dispose();
    inputControllerName.dispose();
    inputControllerSurname.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
