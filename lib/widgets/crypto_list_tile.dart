import 'package:crypto_tracker/model/cryptocurrency.dart';
import 'package:crypto_tracker/provider/crypto_provider.dart';
import 'package:crypto_tracker/provider/theme_provider.dart';
import 'package:crypto_tracker/view/details_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoListTile extends StatelessWidget {
  final Crypto currentCrypto;
  const CryptoListTile({required this.currentCrypto, super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeProvider>(context);
    final cryptoData = Provider.of<CryptoProvider>(context, listen: false);
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(currentCrypto.image!),
      ),
      title: Row(
        children: [
          Text(currentCrypto.name!),
          currentCrypto.isFavourite == false
              ? IconButton(
                  onPressed: () {
                    cryptoData.addToFav(currentCrypto);
                  },
                  icon: const Icon(Icons.favorite_outline_rounded),
                )
              : IconButton(
                  onPressed: () {
                    cryptoData.removeFromFav(currentCrypto);
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                )
        ],
      ),
      subtitle: Text(currentCrypto.symbol!.toUpperCase()),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "₹${currentCrypto.currentPrice}",
            style: TextStyle(
                color: themeData.themeMode == ThemeMode.light
                    ? const Color(0xff560027)
                    : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          Builder(
            builder: ((context) {
              double priceChange = currentCrypto.priceChange24H!;
              double priceChangePercentage =
                  currentCrypto.priceChangePercentage24H!;
              if (priceChange < 0) {
                return Text(
                  '${priceChangePercentage.toStringAsFixed(2)}% ↓',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red),
                );
              } else {
                return Text(
                  '${priceChangePercentage.toStringAsFixed(2)}% ↑',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                );
              }
            }),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => DetailView(
                      id: currentCrypto.id!,
                    ))));
      },
    );
  }
}
