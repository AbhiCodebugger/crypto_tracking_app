import 'package:crypto_tracker/widgets/crypto_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../model/cryptocurrency.dart';
import '../provider/crypto_provider.dart';
import 'details_view.dart';

class CryptoMarket extends StatelessWidget {
  const CryptoMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CryptoProvider>(
      builder: ((context, cryptoData, child) {
        if (cryptoData.isLoading == true) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[700]!,
            highlightColor: Colors.grey[50]!,
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const SizedBox(height: 80),
                );
              },
            ),
          );
        } else {
          if (cryptoData.cryptoData.isNotEmpty) {
            return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                      color: Colors.grey,
                    ),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: cryptoData.cryptoData.length,
                itemBuilder: ((context, index) {
                  Crypto currentCryto = cryptoData.cryptoData[index];
                  return CryptoListTile(currentCrypto: currentCryto);
                }));
          } else {
            return const Center(child: Text('No Data Found'));
          }
        }
      }),
    );
  }
}
