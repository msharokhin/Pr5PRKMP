import 'package:flutter/material.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  final String userEmail;
  final String userName;

  const ProfilePage({
    super.key,
    required this.userEmail,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль пользователя', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.lightGreen.shade100,
                    child: const Icon(Icons.person, size: 70, color: Colors.lightGreen),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.green.shade800,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.badge_outlined, color: Colors.lightGreen),
                      title: const Text('Пользователь', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      subtitle: Text(userName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.email_outlined, color: Colors.lightGreen),
                      title: const Text('Электронная почта', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      subtitle: Text(userEmail, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.group_outlined, color: Colors.lightGreen),
                      title: Text('Студент разработчик', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      subtitle: Text('Шарохин М.С. ИКБО-63-23', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                      (route) => false,
                );
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text('Выйти из аккаунта', style: TextStyle(color: Colors.white, fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
