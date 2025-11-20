import 'package:flutter/material.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Mengubah durasi dari 2 detik menjadi 1.5 detik (1500 milidetik)
    // Anda bisa menyesuaikan angka 1500 ini sesuai kebutuhan (misalnya 1000 untuk 1 detik)
    Timer(const Duration(milliseconds: 1500), () {
      // Periksa context.mounted sebelum navigasi untuk menghindari potential issues
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/main');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset("assets/images/logo.png", width: 180)),
    );
  }
}
