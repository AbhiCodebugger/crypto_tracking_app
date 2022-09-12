import 'package:crypto_tracker/model/cryptocurrency.dart';
import 'package:crypto_tracker/provider/crypto_provider.dart';
import 'package:crypto_tracker/provider/theme_provider.dart';
import 'package:crypto_tracker/view/details_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CryptoCurrency',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Market Price',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: themeProvider.themeMode == ThemeMode.light
                        ? const Icon(
                            Icons.dark_mode,
                          )
                        : const Icon(Icons.light_mode),
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                  )
                ],
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
                        return ListView.separated(
                            separatorBuilder: (context, index) => const Divider(
                                  color: Colors.grey,
                                ),
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "₹${currentCryto.currentPrice}",
                                      style: TextStyle(
                                          color: themeProvider.themeMode ==
                                                  ThemeMode.dark
                                              ? Colors.white
                                              : const Color(0xff560027),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
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
                                            '${priceChangePercentage.toStringAsFixed(2)}% ↓',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          );
                                        } else {
                                          return Text(
                                            '${priceChangePercentage.toStringAsFixed(2)}% ↑',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green),
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
                                                id: currentCryto.id!,
                                              ))));
                                },
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
