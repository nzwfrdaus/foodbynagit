import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodbynagit/pages/main_page.dart'; // Tetap diperlukan untuk map routes
import 'package:foodbynagit/providers/menu_provider.dart';
import 'package:foodbynagit/providers/cart_provider.dart';
import 'package:foodbynagit/theme/app_theme.dart';
import 'package:foodbynagit/pages/splash.dart'; // Diperlukan untuk map routes

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Dengan Named Routes, kita menggunakan initialRoute dan routes, bukan home:
    return MaterialApp(
      title: 'FoodByNagit',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      // Tentukan halaman awal (SplashPage)
      initialRoute: '/',

      // Daftarkan semua rute
      routes: {
        // '/'/ adalah rute utama yang akan menampilkan SplashPage
        '/': (context) => const SplashPage(),
        // '/main' adalah rute tujuan setelah splash screen selesai
        '/main': (context) => const MainPage(),
      },
    );
  }
}
