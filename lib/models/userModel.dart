class UserModel {
  String? id;
  String? seviye;
  int? totalDogruCevap;
  int? totalYanlisCevap;
  int? totalPuan;
  int? enSonDogruCevap;
  int? enSonYanlisCevap;
  int? enSonPuan;
  int? enYuksekPuan;
  int? enYuksekDogruCevap;
  int? enYuksekYanlisCevap;
  String? enYuksekTarih;
  String? enSonTarih;

  UserModel(
      {required this.id,
      required this.seviye,
      required this.totalDogruCevap,
      required this.totalYanlisCevap,
      required this.totalPuan,
      required this.enSonDogruCevap,
      required this.enSonYanlisCevap,
      required this.enSonPuan,
      required this.enYuksekPuan,
      required this.enYuksekDogruCevap,
      required this.enYuksekYanlisCevap,
      required this.enYuksekTarih,
      required this.enSonTarih});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seviye = json['seviye'];
    totalDogruCevap = json['totalDogruCevap'];
    totalYanlisCevap = json['totalYanlisCevap'];
    totalPuan = json['totalPuan'];
    enSonDogruCevap = json['enSonDogruCevap'];
    enSonYanlisCevap = json['enSonYanlisCevap'];
    enSonPuan = json['enSonPuan'];
    enYuksekPuan = json['enYuksekPuan'];
    enYuksekDogruCevap = json['enYuksekDogruCevap'];
    enYuksekYanlisCevap = json['enYuksekYanlisCevap'];
    enYuksekTarih = json['enYuksekTarih'];
    enSonTarih = json['enSonTarih'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['seviye'] = seviye;
    data['totalDogruCevap'] = totalDogruCevap;
    data['totalYanlisCevap'] = totalYanlisCevap;
    data['totalPuan'] = totalPuan;
    data['enSonDogruCevap'] = enSonDogruCevap;
    data['enSonYanlisCevap'] = enSonYanlisCevap;
    data['enSonPuan'] = enSonPuan;
    data['enYuksekPuan'] = enYuksekPuan;
    data['enYuksekDogruCevap'] = enYuksekDogruCevap;
    data['enYuksekYanlisCevap'] = enYuksekYanlisCevap;
    data['enYuksekTarih'] = enYuksekTarih;
    data['enSonTarih'] = enSonTarih;
    return data;
  }

  UserModel.empty() {
    id = "";
    seviye = "";
    totalDogruCevap = 0;
    totalYanlisCevap = 0;
    totalPuan = 0;
    enSonDogruCevap = 0;
    enSonYanlisCevap = 0;
    enSonPuan = 0;
    enYuksekPuan = 0;
    enYuksekDogruCevap = 0;
    enYuksekYanlisCevap = 0;
    enYuksekTarih = "";
    enSonTarih = "";
  }
}
