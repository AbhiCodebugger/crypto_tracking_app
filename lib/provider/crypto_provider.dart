import 'dart:async';

import 'package:crypto_tracker/model/cryptocurrency.dart';
import 'package:crypto_tracker/service/api_service.dart';
import 'package:crypto_tracker/storage/local_db.dart';
import 'package:flutter/cupertino.dart';

class CryptoProvider extends ChangeNotifier {
  bool isLoading = true;
  List<Crypto> cryptoData = [];

  CryptoProvider() {
    fetchCrypto();
  }

  void fetchCrypto() async {
    List<dynamic> _cryptoData = await ApiService.getCrptoData();
    List<String> favourites = await LocalDB.getFavourite();
    List<Crypto> temp = [];
    for (var crypto in _cryptoData) {
      Crypto newCrypto = Crypto.fromJson(crypto);
      if (favourites.contains(newCrypto.id!)) {
        newCrypto.isFavourite = true;
      }
      temp.add(newCrypto);
    }
    cryptoData = temp;
    isLoading = false;
    notifyListeners();
    Timer(const Duration(seconds: 3), () {
      fetchCrypto();
    });
  }

  Crypto fetchCryptoById(String id) {
    Crypto crypto = cryptoData.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  void addToFav(Crypto cryptoCurrency) async {
    int index = cryptoData.indexOf(cryptoCurrency);
    cryptoData[index].isFavourite = true;
    await LocalDB.setFavourites(cryptoCurrency.id!);
    notifyListeners();
  }

  void removeFromFav(Crypto cryptoCurrency) async {
    int index = cryptoData.indexOf(cryptoCurrency);
    cryptoData[index].isFavourite = false;
    await LocalDB.removeFavourites(cryptoCurrency.id!);
    notifyListeners();
  }
}
