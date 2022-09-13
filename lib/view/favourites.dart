import 'package:crypto_tracker/model/cryptocurrency.dart';
import 'package:crypto_tracker/provider/crypto_provider.dart';
import 'package:crypto_tracker/widgets/crypto_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class MyFavourites extends StatelessWidget {
  const MyFavourites({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeProvider>(context);

    return Consumer<CryptoProvider>(builder: ((context, cryptoProvider, child) {
      List<Crypto> favourites = cryptoProvider.cryptoData
          .where((item) => item.isFavourite == true)
          .toList();
      if (favourites.isNotEmpty) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: favourites.length,
          separatorBuilder: ((context, index) => Divider(
                color: themeData.themeMode == ThemeMode.light
                    ? Colors.black
                    : Colors.white,
              )),
          itemBuilder: ((context, index) {
            Crypto crypto = favourites[index];
            return CryptoListTile(
              currentCrypto: crypto,
            );
          }),
        );
      } else {
        return const Center(
          child: Text(
            "No favorites yet",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
        );
      }
    }));
  }
}
