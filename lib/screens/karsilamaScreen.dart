// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:learn_eng/data/sharedPreferences.dart';
import 'package:learn_eng/screens/homeScreen.dart';
import 'package:learn_eng/screens/seviyeBelirlemeScreen.dart';

class KarsilamaScreen extends StatefulWidget {
  const KarsilamaScreen({super.key});

  @override
  State<KarsilamaScreen> createState() => _KarsilamaScreenState();
}

class _KarsilamaScreenState extends State<KarsilamaScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CupertinoApp(
          color: Colors.white,
          debugShowCheckedModeBanner: false,
          home: OnBoardingSlider(
            headerBackgroundColor: Colors.white,
            finishButtonText: 'Öğrenmeye Başla',
            finishButtonStyle: const FinishButtonStyle(
              backgroundColor: Colors.deepPurple,
            ),
            onFinish: () {
              Sharedpreferences.saveLogin();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SeviyeBelirlemeScreen()),
              );
            },
            skipTextButton: const Text('Atla'),
            //  trailing: Text('Login'),
            background: [
              Image.asset(
                'assets/ing.png',
                height: MediaQuery.of(context).size.height * 0.45,
              ),
              Image.asset(
                'assets/ii.png',
                height: MediaQuery.of(context).size.height * 0.32,
              ),
              Image.asset(
                'assets/b.jpg',
                height: MediaQuery.of(context).size.height * 0.33,
              ),
            ],
            totalPage: 3,
            speed: 1.8,
            pageBodies: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                    const Text(
                      'Dünya ile bağ kurmak için İngilizce öğren. Yeni arkadaşlıklar seni bekliyor!',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                    const Text(
                      'İngilizce bilmek, dünyanın dört bir yanını keşfederken daha rahat iletişim kurmanı sağlar',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                    const Text(
                      'Yeni bir dil, yeni bir dünya demektir. Zihnini geliştir ve ufkunu genişlet!',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
