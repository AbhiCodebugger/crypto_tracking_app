import 'package:crypto_tracker/constant/themes.dart';
import 'package:crypto_tracker/provider/crypto_provider.dart';
import 'package:crypto_tracker/provider/theme_provider.dart';
import 'package:crypto_tracker/storage/local_db.dart';
import 'package:crypto_tracker/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String currentTheme = await LocalDB.getTheme() ?? "light";
  runApp(MyApp(
    theme: currentTheme,
  ));
}

class MyApp extends StatelessWidget {
  final String theme;
  const MyApp({required this.theme, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CryptoProvider>(
          create: ((context) => CryptoProvider()),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: ((context) => ThemeProvider(theme)),
        )
      ],
      child: Consumer<ThemeProvider>(
        builder: ((context, theme, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: lighTheme,
            darkTheme: darkTheme,
            themeMode: theme.themeMode,
            home: const HomeView(),
          );
        }),
      ),
    );
  }
}
