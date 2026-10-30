import 'package:flutter/material.dart';
import '../routes.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // Имитация инициализации приложения на 4 секунды
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      // Заменяем экран заставки на экран логина без сохранения в стеке
      Navigator.pushReplacementNamed(context, Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Тематическая иконка видеокарты
            const Icon(Icons.developer_board, size: 100, color: Colors.lightGreen),
            const SizedBox(height: 24),
            const Text(
              'GPU DATABASE',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.lightGreen),
            ),
            const SizedBox(height: 32),
            // Индикатор загрузки по макету
            CircularProgressIndicator(color: Colors.green.shade800),
          ],
        ),
      ),
    );
  }
}
