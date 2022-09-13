import 'package:crypto_tracker/model/cryptocurrency.dart';
import 'package:crypto_tracker/provider/crypto_provider.dart';
import 'package:crypto_tracker/provider/theme_provider.dart';
import 'package:crypto_tracker/view/crypto_market.dart';
import 'package:crypto_tracker/view/details_view.dart';
import 'package:crypto_tracker/view/favourites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
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
              TabBar(
                controller: tabController,
                tabs: [
                  Tab(
                    child: Text(
                      'Market',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Favourite',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: tabController,
                  children: const [
                    CryptoMarket(),
                    MyFavourites(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
