import 'dart:async';

import 'package:crypto_tracker/model/cryptocurrency.dart';
import 'package:crypto_tracker/service/api_service.dart';
import 'package:flutter/cupertino.dart';

class CryptoProvider extends ChangeNotifier {
  bool isLoading = true;
  List<Crypto> cryptoData = [];

  CryptoProvider() {
    fetchCrypto();
  }

  void fetchCrypto() async {
    List<dynamic> _cryptoData = await ApiService.getCrptoData();
    List<Crypto> temp = [];
    for (var crypto in _cryptoData) {
      Crypto newCrypto = Crypto.fromJson(crypto);
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
}
