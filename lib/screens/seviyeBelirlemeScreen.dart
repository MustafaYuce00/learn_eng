import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_eng/consts/methods.dart';
import 'package:learn_eng/consts/sabitler.dart';
import 'package:learn_eng/data/a1.dart';
import 'package:learn_eng/data/a2.dart';
import 'package:learn_eng/data/b1.dart';
import 'package:learn_eng/data/b2.dart';
import 'package:learn_eng/data/sharedPreferences.dart';
import 'package:learn_eng/models/soruModel.dart';
import 'package:learn_eng/models/userModel.dart';
import 'package:learn_eng/screens/homeScreen.dart';

class SeviyeBelirlemeScreen extends StatefulWidget {
  const SeviyeBelirlemeScreen({super.key});

  @override
  State<SeviyeBelirlemeScreen> createState() => _SeviyeBelirlemeScreenState();
}

class _SeviyeBelirlemeScreenState extends State<SeviyeBelirlemeScreen>
    with TickerProviderStateMixin {
  Random random = Random();
  int dogruCevap = 0;
  int currentQuestionIndex = 0;
  late List<String> shuffledOptions;
  String? seviye;

  List<Soru> sorular = [];

  @override
  void initState() {
    super.initState();
    sorulariAl(); //soruları al fonksiyonunu çağırıyoruz ki soruları alalım

    currentQuestionIndex = 0;
    shuffleOptions();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffb28cee),
                Color(0xffd9eaff),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                // seviye belirleme bilgilendirme metni
                Container(
                  width: MediaQuery.of(context).size.width,
                  //  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        'Seviye Belirleme Testi 8 Sorudan Oluşmaktadır.Süre Sınırı Yoktur. Cevabı seçerek başlıyabilirsiniz. \n*Seviyenizi belirlemek için bütün soruları cevaplamalısınız.',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // doğru cevap sayısı ve soru sayısı gösterimi için
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Doğru Cevap: $dogruCevap / ${sorular.length}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // soru sayısı
                questions(context),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      if (Sabitler.userModel!.seviye == "") {
                        //! seviye belirleme işlemi yapılıyor
                        userSeviye();
                      } else {
                        //! sorular bittiğinde
                        userSeviye();
                      }

                      // seviye belirleme atla
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false);
                    },
                    child: Text("Seviye Belirlemeyi Şimdilik Atla")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column questions(BuildContext context) {
    return Column(
      children: [
        // soru
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              sorular[currentQuestionIndex].soruMetni!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // cevaplar
        Column(
          children: [
            for (var i = 0; i < 4; i++)
              GestureDetector(
                onTap: () {
                  checkAnswer(shuffledOptions[i]);
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      shuffledOptions[i],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  void shuffleOptions() {
    shuffledOptions = List.from(sorular[currentQuestionIndex].secenekler!);
    shuffledOptions.shuffle();
  }

  void checkAnswer(
    String selectedAnswer,
  ) {
    if (currentQuestionIndex >= sorular.length - 1) {
      //! sorular bittiğinde
      userSeviye();
      // kullanıcı kaydı yapılıyor

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
    }
    if (selectedAnswer == sorular[currentQuestionIndex].dogruCevap!) {
      //! doğru cevap verildiğinde
      setState(() {
        currentQuestionIndex += 1;
        shuffleOptions();
        dogruCevap++;
      });
    } else {
      //! yanlış cevap verildiğinde
      setState(() {});
      // Yanlış cevap, verdiğini bildirme işlemi üstbildirim ile yapılabilir
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              animation: AnimationController(
                vsync: this,
                duration: const Duration(seconds: 1),
              ),
              content: Column(
                children: [
                  Text('Yanlış Cevap: $selectedAnswer'),
                  Text(
                      'Doğru Cevap: ${sorular[currentQuestionIndex].dogruCevap}'),
                ],
              ),
              duration: const Duration(milliseconds: 1500),
            ),
          )
          .closed
          .then((reason) {
        setState(() {
          currentQuestionIndex = currentQuestionIndex + 1;
          shuffleOptions();
        });
      });

      // Yanlış cevap, istenilen işlemi yapabilirsiniz.
    }
  }

  void userSeviye() {
    seviyeBelirle();
    print(seviye! + ":aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    
    Sabitler.userModel!.seviye = seviye;
    Sabitler.userModel!.totalDogruCevap =
        Sabitler.userModel!.totalDogruCevap! + dogruCevap;
    Sabitler.userModel!.totalYanlisCevap =
        Sabitler.userModel!.totalYanlisCevap! + (sorular.length - dogruCevap);
    Sabitler.userModel!.totalPuan =
        Sabitler.userModel!.totalPuan! + dogruCevap * 10;
    Sabitler.userModel!.enSonDogruCevap = dogruCevap;
    Sabitler.userModel!.enSonYanlisCevap = sorular.length - dogruCevap;
    Sabitler.userModel!.enSonPuan = dogruCevap * 10;
    Methods.enYuksek(Sabitler.userModel!.enYuksekPuan!, dogruCevap * 10) == true
        ? Sabitler.userModel!.enYuksekPuan = dogruCevap * 10
        : Sabitler.userModel!.enYuksekPuan = Sabitler.userModel!.enYuksekPuan!;
    Methods.enYuksek(Sabitler.userModel!.enYuksekDogruCevap!, dogruCevap) ==
            true
        ? Sabitler.userModel!.enYuksekDogruCevap = dogruCevap
        : Sabitler.userModel!.enYuksekDogruCevap =
            Sabitler.userModel!.enYuksekDogruCevap!;
    Methods.enYuksek(Sabitler.userModel!.enYuksekYanlisCevap!,
                sorular.length - dogruCevap) ==
            true
        ? Sabitler.userModel!.enYuksekYanlisCevap = sorular.length - dogruCevap
        : Sabitler.userModel!.enYuksekYanlisCevap =
            Sabitler.userModel!.enYuksekYanlisCevap!;
    Sabitler.userModel!.enYuksekTarih = DateTime.now().toString();
    Sabitler.userModel!.enSonTarih = DateTime.now().toString();
    Sharedpreferences.saveUser(Sabitler.userModel!);
  }

  // Seviye belirleme metodu
  void seviyeBelirle() {
    if (dogruCevap <= 2 ) {
      seviye = 'A1';
    } else if (dogruCevap <= 4 ) {
      seviye = 'A2';
    } else if (dogruCevap <= 6 ) {
      seviye = 'B1';
    } else if (dogruCevap <= 8 ) {
      seviye = 'B2';
    } else {
      seviye = "";
    }

    // shered preferences ile seviye bilgisini saklanacak
  }

  sorulariAl() {
    // var a1 = A1List.a1Sorular.where();
    for (var i = 0; i < 2; i++) {
      var soru = A1List.a1Sorular[random.nextInt(A1List.a1Sorular.length)];
      sorular.add(soru);
    }
    for (var i = 0; i < 2; i++) {
      var soru = A2List.a2Sorular[random.nextInt(A2List.a2Sorular.length)];
      sorular.add(soru);
    }
    for (var i = 0; i < 2; i++) {
      var soru = B1List.b1Sorular[random.nextInt(B1List.b1Sorular.length)];
      sorular.add(soru);
    }
    for (var i = 0; i < 2; i++) {
      var soru = B2List.b2Sorular[random.nextInt(B2List.b2Sorular.length)];
      sorular.add(soru);
    }
  }
}
