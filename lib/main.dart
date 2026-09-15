import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/theme_provider.dart';
import 'data/order_storage.dart';
import 'features/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await OrderStorage.loadOrders();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    ChangeNotifierProvider(
      create: (_) => themeProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Artisan App',

          themeMode: themeProvider.isDark
              ? ThemeMode.dark
              : ThemeMode.light,

          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor:
                const Color(0xffF5F7FA),
            brightness: Brightness.light,
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor:
                const Color(0xff121212),

            cardColor:
                const Color(0xff1E1E1E),

            appBarTheme: const AppBarTheme(
              backgroundColor:
                  Color(0xff1E1E1E),
            ),
          ),

          home: const SplashScreen(),
        );
      },
    );
  }
}