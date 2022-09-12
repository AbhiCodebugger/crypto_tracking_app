import 'package:crypto_tracker/model/cryptocurrency.dart';
import 'package:crypto_tracker/provider/crypto_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailView extends StatelessWidget {
  String id;
  DetailView({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Consumer<CryptoProvider>(
            builder: ((context, cryptoProvider, child) {
          Crypto cryptoCurrency = cryptoProvider.fetchCryptoById(id);
          return ListView(
              padding: const EdgeInsets.all(12),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(cryptoCurrency.image!)),
                  title: Row(
                    children: [
                      Text(
                        cryptoCurrency.name!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "(${cryptoCurrency.symbol!.toUpperCase()})",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "₹${cryptoCurrency.currentPrice.toString().toUpperCase()}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                SizedBox(height: 20),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    'Price change(24h)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Builder(builder: ((context) {
                    double priceChange = cryptoCurrency.priceChange24H!;
                    double priceChangePercentage =
                        cryptoCurrency.priceChangePercentage24H!;
                    if (priceChange < 0) {
                      return Text(
                        "₹${priceChangePercentage.toString()} ↓",
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    } else {
                      return Text(
                        "+$priceChangePercentage% ↑",
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  })),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildContent(
                          'High(24)',
                          "₹${cryptoCurrency.high24H.toString()}",
                          CrossAxisAlignment.start),
                      buildContent(
                          'Low(24)',
                          "₹${cryptoCurrency.low24H.toString()}",
                          CrossAxisAlignment.end)
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildContent(
                          'All Time High',
                          "₹${cryptoCurrency.ath.toString()}",
                          CrossAxisAlignment.start),
                      buildContent(
                          'All Time Low',
                          "₹${cryptoCurrency.atl.toString()}",
                          CrossAxisAlignment.end)
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildContent(
                          'MarketCap',
                          "₹${cryptoCurrency.marketCap.toString()}",
                          CrossAxisAlignment.start),
                      buildContent(
                          'MarketCapRank',
                          "#${cryptoCurrency.marketCapRank.toString()}",
                          CrossAxisAlignment.end),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildContent(
                          'Circulating Supply',
                          "${cryptoCurrency.circulatingSupply!.toStringAsFixed(0)} Btc",
                          CrossAxisAlignment.start),
                      buildContent(
                          'Total Supply',
                          "${cryptoCurrency.totalVolume!.toStringAsFixed(0)} Btc",
                          CrossAxisAlignment.end),
                    ],
                  ),
                ])
              ]);
        })),
      ),
    );
  }

  buildContent(
      String title, String text, CrossAxisAlignment crossAxisAlignment) {
    return Card(
      elevation: 4.0,
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            const SizedBox(height: 6),
            Text(
              text.toString(),
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}
