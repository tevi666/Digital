import 'package:flutter/material.dart';
import 'pages/registration/registration_page.dart';
import '../utilities/constants/app_colors.dart';

class Digital extends StatelessWidget {
  const Digital({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedItemColor: AppColors.unselected,
          selectedItemColor: AppColors.selected,
          elevation: 0,
        ),
        scaffoldBackgroundColor: AppColors.primary,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.primary,
        ),
      ),
      home: const RegistrationPage(),
    );
  }
}
