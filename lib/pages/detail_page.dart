import 'package:flutter/material.dart';
import '../models/video_card.dart'; // Добавлен импорт модели

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Извлекаем строго типизированный объект модели VideoCard по условию ТЗ 7 практики
    final card = ModalRoute.of(context)!.settings.arguments as VideoCard;

    return Scaffold(
      appBar: AppBar(
        title: Text(card.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(card.image, height: 260, fit: BoxFit.contain),
            ),
            const SizedBox(height: 24),
            Text(
              card.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.lightGreen),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.grey.shade50,
              ),
              child: Text(
                card.fullDescription,
                style: const TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
