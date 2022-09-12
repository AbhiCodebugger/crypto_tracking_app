import 'package:crypto_tracker/model/cryptocurrency.dart';
import 'package:crypto_tracker/provider/crypto_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 10, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cryto Currency',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const Text(
                'Today',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Consumer<CryptoProvider>(
                  builder: ((context, data, child) {
                    if (data.isLoading == true) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (data.cryptoData.isNotEmpty) {
                        return ListView.builder(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: data.cryptoData.length,
                            itemBuilder: ((context, index) {
                              Crypto currentCryto = data.cryptoData[index];
                              return ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      NetworkImage(currentCryto.image!),
                                ),
                                title: Text(currentCryto.name!),
                                subtitle:
                                    Text(currentCryto.symbol!.toUpperCase()),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "₹ ${currentCryto.currentPrice}",
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Builder(
                                      builder: ((context) {
                                        double priceChange =
                                            currentCryto.priceChange24H!;
                                        double priceChangePercentage =
                                            currentCryto
                                                .priceChangePercentage24H!;
                                        if (priceChange < 0) {
                                          return Text(
                                            '${priceChangePercentage.toStringAsFixed(2)}% (₹${priceChange.toStringAsFixed(3)})',
                                            style: const TextStyle(
                                                color: Colors.red),
                                          );
                                        } else {
                                          return Text(
                                            '${priceChangePercentage.toStringAsFixed(2)}% (₹${priceChange.toStringAsFixed(3)})',
                                            style: const TextStyle(
                                                color: Colors.green),
                                          );
                                        }
                                      }),
                                    ),
                                  ],
                                ),
                              );
                            }));
                      } else {
                        return const Text('No Data Found');
                      }
                    }
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
