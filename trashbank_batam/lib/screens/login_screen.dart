import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

/// Halaman 2: Login Statis (tanpa autentikasi)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _sembunyi = true;

  void _masuk() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 48),
              const Icon(Icons.recycling, size: 72, color: AppColors.primary),
              const SizedBox(height: 16),
              const Text('TrashBank Batam',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const Text('Masuk untuk melanjutkan',
                  style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 32),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: _sembunyi,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _sembunyi ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _sembunyi = !_sembunyi),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _masuk, child: const Text('Masuk')),
              const SizedBox(height: 16),
              const Text('atau',
                  style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _masuk,
                icon: const Icon(Icons.g_mobiledata, size: 32),
                label: const Text('Masuk dengan Google'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
