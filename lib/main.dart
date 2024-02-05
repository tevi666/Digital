import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sobol_digital/data/local/avatar_provider.dart';
import 'package:sobol_digital/data/local/registration_provider.dart';
import 'package:sobol_digital/data/local/user_info_provider.dart';
import 'package:sobol_digital/presentations/app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserInfoProvider()),
        ChangeNotifierProvider(create: (context) => AvatarProvider()), 
        ChangeNotifierProvider(create: (context) => RegistrationProvider()),
      ],
      child: const Digital(),
    ),
  );
}


