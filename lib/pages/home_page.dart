import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/video_cards_bloc.dart';
import '../models/video_card.dart';
import '../widgets/text_field.dart';
import '../routes.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<String> sliderImages = [
    'assets/pr2.jpg',
    'assets/580.jpg',
    'assets/4070.jpg',
    'assets/4080.jpeg',
    'assets/5090.jpg',
    'assets/7900.jpg',
  ];

  // Дальше идет весь ваш неизмененный код: @override Widget build(BuildContext context) { ... }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>? ?? {};
    final String userEmail = args['email'] ?? 'example@mail.com';
    final String userName = args['name'] ?? 'Шарохин М.С.';

    final List<Widget> screens = [
      _buildVideoCardsTab(),
      _buildProfileTab(context, userName, userEmail),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'ВИДЕОКАРТЫ' : 'ПРОФИЛЬ ПОЛЬЗОВАТЕЛЯ', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        automaticallyImplyLeading: false,
      ),
      body: IndexedStack(index: _selectedIndex, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        backgroundColor: Colors.lightGreen.shade50,
        indicatorColor: Colors.lightGreen.shade200,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.developer_board_outlined), selectedIcon: Icon(Icons.developer_board), label: 'Главная'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }

  Widget _buildVideoCardsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4.0)),
            child: const Text('Графические ускорители (GPU)', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: sliderImages.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) => ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(sliderImages[index], width: 200, fit: BoxFit.cover)),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Каталог моделей ускорителей', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          // ИЗМЕНЕНИЕ: Внедряем BlocBuilder для реактивного управления состояниями UI
          BlocBuilder<VideoCardsBloc, VideoCardsState>(
            builder: (context, state) {
              switch (state) {
                case VideoCardsInitial():
                  return const Center(child: Text('Ожидание инициализации потока данных...'));
                case VideoCardsLoading():
                  return Center(child: Padding(padding: const EdgeInsets.all(24.0), child: CircularProgressIndicator(color: Colors.green.shade800)));
                case VideoCardsError(:final message):
                  return Center(child: Text(message, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)));
                case VideoCardsLoaded(:final cards):
                  if (cards.isEmpty) return const Center(child: Text('Каталог пуст'));

                  // Выводим наш проверенный адаптивный дизайн из 6-й практики
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 600) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 2.8),
                          itemCount: cards.length,
                          itemBuilder: (context, index) => _buildBrandCard(cards[index]),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cards.length,
                          itemBuilder: (context, index) => _buildBrandCard(cards[index]),
                        );
                      }
                    },
                  );
              }
            },
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4.0)),
            child: const Row(
              children: [
                Icon(Icons.account_box_outlined, size: 32, color: Colors.black54),
                SizedBox(width: 12),
                Text('Шарохин М.С. ИКБО-63-23', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandCard(VideoCard card) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: const Icon(Icons.memory, color: Colors.lightGreen, size: 32),
        title: Text(card.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(card.shortDescription, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Навигация на экран детализации по именованному маршруту с передачей объекта модели
          Navigator.pushNamed(context, Routes.detail, arguments: card);
        },
      ),
    );
  }

  Widget _buildProfileTab(BuildContext context, String name, String email) {
    final profileFormKey = GlobalKey<FormState>();
    final pName = TextEditingController(text: name);
    final pEmail = TextEditingController(text: email);
    final pPass = TextEditingController();
    final pConfirm = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: profileFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Center(child: CircleAvatar(radius: 50, backgroundColor: Colors.lightGreen.shade100, child: Icon(Icons.person_outline, size: 60, color: Colors.green.shade800))),
            const SizedBox(height: 32),
            CustomTextFormField(inputType: InputFieldType.name, labelText: "Ваше имя", hintText: "Имя", prefixIcon: const Icon(Icons.person_outline), controller: pName),
            const SizedBox(height: 16),
            CustomTextFormField(inputType: InputFieldType.email, labelText: "Email", hintText: "email", prefixIcon: const Icon(Icons.email_outlined), controller: pEmail),
            const SizedBox(height: 16),
            CustomTextFormField(inputType: InputFieldType.password, labelText: "Пароль", hintText: "Пароль", prefixIcon: const Icon(Icons.lock_outline), controller: pPass),
            const SizedBox(height: 16),
            CustomTextFormField(inputType: InputFieldType.confirmPassword, labelText: "Повторите пароль", hintText: "Повторите пароль", prefixIcon: const Icon(Icons.lock_clock_outlined), controller: pConfirm, passwordToMatch: pPass),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (profileFormKey.currentState?.validate() ?? false) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('Изменения сохранены!'), backgroundColor: Colors.green.shade800));
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade600, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text('Сохранить', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (route) => false),
              icon: const Icon(Icons.logout, color: Colors.white, size: 18),
              label: const Text('Выйти из системы', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            ),
          ],
        ),
      ),
    );
  }
}
