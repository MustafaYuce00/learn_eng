import 'package:learn_eng/data/sharedPreferences.dart';
import 'package:learn_eng/models/userModel.dart';

class Methods {
  String seviyeBelirle(int dogruCevap) {
    if (dogruCevap < 2 && dogruCevap > -1) {
      return 'A1';
    } else if (dogruCevap < 4) {
      return 'A2';
    } else if (dogruCevap < 6) {
      return 'B1';
    } else {
      return 'B2';
    }
  }

  static bool enYuksek(int ilk, int son) {
    if (ilk > son) {
      return true;
    } else {
      return false;
    }
  }

  static seviyeBelirleGenel(bool SeviyeB1elirleAtlaMi) {
    // shered preferences ile seviye bilgisini saklanacak
    UserModel userModel = UserModel.empty();

    if (SeviyeB1elirleAtlaMi) {
      userModel.seviye = '';
      Sharedpreferences.saveUser(userModel);
    } else {
      return 'B2';
    }
  }
}
