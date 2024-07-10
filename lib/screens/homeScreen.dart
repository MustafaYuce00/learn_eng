import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:learn_eng/consts/sabitler.dart';
import 'package:learn_eng/screens/seviyeBelirlemeScreen.dart';
import 'package:learn_eng/screens/testScreen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var data = [
    {
      'id': 1,
      'name': 'A1',
      'description': 'Beginner',
      'image': 'assets/a1.png',
      "Color": "#c39dff",
    },
    {
      'id': 1.3,
      'name': 'A2',
      'description': 'Elementary',
      'image': 'assets/a2.png',
      "Color": "#c8d0ff",
    },
    {
      'id': 1.6,
      'name': 'B1',
      'description': 'Intermediate',
      'image': 'assets/b1.png',
      "Color": "#a4ff7e",
    },
    {
      'id': 1.9,
      'name': 'B2',
      'description': 'Upper Intermediate',
      'image': 'assets/b2.png',
      "Color": "#fff777",
    },
    /* 
 {
      'id': 5,
      'name': 'C1',
      'description': 'Advanced',
      'image': 'assets/c1.png',
      "Color": "#ffc148",
    },
    {
      'id': 6,
      'name': 'C2',
      'description': 'Proficiency',
      'image': 'assets/c2.png',
      "Color": "#f18491",
    }
    */
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[200],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // en yüksek skoru gösterip en çok soru çözülen kategoriyi göster
              Column(
                children: [
                  Container(
                    color: Colors.deepPurple,
                    child: Row(
                      children: [
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SeviyeBelirlemeScreen(),
                                ),
                                (route) => false);
                          },
                          icon:
                              Icon(Icons.leaderboard, color: Colors.grey[200]),
                        ),
                      ],
                    ),
                  ),
                  // En yüksek skor ve en çok puan toplam puan toplam doğru ve yanlış cevap sayıları göster
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.deepPurple,
                          Colors.blueAccent,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        //    top: MediaQuery.of(context).size.height * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        bottom: MediaQuery.of(context).size.height * 0.02,
                      ),
                      child: Card(
                        elevation: 50,
                        color: Colors.grey[200],
                        child:Column(
                          children: [
                            Text(Sabitler.userModel!.seviye.toString() + " Seviye"),
                            Text(Sabitler.userModel!.enSonPuan.toString() + " En Son Puan"),
                            Text(Sabitler.userModel!.totalPuan.toString() + " total Puan"),
                            Text(Sabitler.userModel!.totalDogruCevap.toString() + " total Doğru Cevap"),
                            Text(Sabitler.userModel!.totalYanlisCevap.toString() + " total Yanlış Cevap"),
                            Text(Sabitler.userModel!.enYuksekPuan.toString() + " En Yüksek Puan"),
                            Text(Sabitler.userModel!.enYuksekDogruCevap.toString() + " En Yüksek Doğru Cevap"),
                            Text(Sabitler.userModel!.enYuksekYanlisCevap.toString() + " En Yüksek Yanlış Cevap"),
                            Text(Sabitler.userModel!.enSonDogruCevap.toString() + " En Son Doğru Cevap"),
                            Text(Sabitler.userModel!.enSonYanlisCevap.toString() + " En Son Yanlış Cevap"),


                          ],
                        )
                     /*   child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    'En Yüksek Skor',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    'En Yüksek Puan',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    '100',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '100',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    'Toplam Puan',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Toplam Doğru Cevap',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    '100',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),*/
                      ),
                    ),
                  ),
                ],
              ),
              // Kategoriler
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                //   color: Colors.grey[200],
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.white38],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    data.length,
                    (index) {
                      return AnimationConfiguration.staggeredGrid(
                        columnCount: 1,
                        position: index,
                        duration: const Duration(milliseconds: 350),
                        child: ScaleAnimation(
                          scale: 0.5,
                          curve: Curves.easeInCubic,
                          //  curve: Curves.easeIn,
                          child: FadeInAnimation(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TestScreen(
                                        data: data[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.2 *
                                            double.parse(
                                                data[index]['id'].toString()),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: hexToColor(
                                              data[index]["Color"].toString()),
                                        ),
                                        child: Center(
                                          child: Text(
                                            data[index]['name'].toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                            ),
                                          ).animate().fade().scale(),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        data[index]['description'].toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ).animate().fade().scale(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  //! Hex kodunu renk koduna çevir
  Color hexToColor(String hex) {
    // Renk kodunun "#" karakterini kaldır
    hex = hex.replaceAll("#", "");

    // Eğer renk kodu 6 karakter ise başına "ff" ekle (şeffaflık tam)
    if (hex.length == 6) {
      hex = "ff$hex";
    }

    // Hex kodunu integer'a çevir ve Color'a dönüştür
    return Color(int.parse(hex, radix: 16));
  }
}
