import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {

    final brand = ModalRoute.of(context)!.settings.arguments as Map<String, String>? ?? {};
    final String title = brand['title'] ?? 'Неизвестный ускоритель';
    final String description = brand['description'] ?? 'Описание отсутствует';
    final String image = brand['image'] ?? 'assets/pr2.jpg';

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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
            // Постер видеокарты со скруглением
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(image, height: 260, fit: BoxFit.contain),
            ),
            const SizedBox(height: 24),
            Text(
              title,
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
                description,
                style: const TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
