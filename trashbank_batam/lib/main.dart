import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const TrashBankApp());
}

class TrashBankApp extends StatelessWidget {
  const TrashBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrashBank Batam',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(), // halaman pertama
    );
  }
}
