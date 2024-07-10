import 'package:flutter/material.dart';
import 'package:learn_eng/consts/sabitler.dart';
import 'package:learn_eng/data/sharedPreferences.dart';
import 'package:learn_eng/models/userModel.dart';
import 'package:learn_eng/screens/homeScreen.dart';
import 'package:learn_eng/screens/karsilamaScreen.dart';
import 'package:learn_eng/screens/seviyeBelirlemeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(const MyApp());
}

Future<void> init() async {
  if (Sabitler.userModel == null) {
    var tempUser = await Sharedpreferences.getUser();
    if (tempUser != null) {
      Sabitler.userModel = tempUser;
    } else {
      Sabitler.userModel = UserModel.empty();
    }
  }
  Sabitler.isLogin = await Sharedpreferences.getLogin();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn Engish',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Sabitler.isLogin == false
          ? const KarsilamaScreen()
          : Sabitler.userModel!.seviye == ''
              ? const SeviyeBelirlemeScreen()
              : const HomeScreen(),
    );
  }
}
