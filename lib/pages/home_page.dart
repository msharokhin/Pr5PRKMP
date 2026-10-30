import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '../routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
int _selectedIndex = 0; // Индекс выбранной вкладки для нижней панели

// Списки данных
final List<String> images = [
'assets/pr2.jpg',
'assets/580.jpg',
'assets/4070.jpg',
'assets/4080.jpeg',
'assets/5090.jpg',
'assets/7900.jpg',
];

final List<Map<String, String>> brands = [
{
'title': 'NVIDIA GeForce RTX 5090',
'description': 'Флагман архитектуры Blackwell. 32 ГБ GDDR7 памяти, непревзойденная производительность в 4K играх и трассировке лучей.',
'image': 'assets/5090.jpg',
},
{
'title': 'NVIDIA GeForce RTX 4070',
'description': 'Оптимальное решение для 2K-гейминга на архитектуре Ada Lovelace с поддержкой генерации кадров DLSS 3.',
'image': 'assets/4070.jpg',
},
{
'title': 'AMD Radeon RX 7900 XTX',
'description': 'Топовый ускоритель на чиплетах RDNA 3. 24 ГБ видеопамяти и высочайшая чистая растровая производительность.',
'image': 'assets/7900.jpg',
},
{
'title': 'NVIDIA GeForce GTX 580',
'description': 'Легендарный представитель архитектуры Fermi. Исторический ускоритель, заложивший основы современных GPU.',
'image': 'assets/580.jpg',
},
];

@override
Widget build(BuildContext context) {
// Получаем переданные аргументы (имя, email)
final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>? ?? {};
final String userEmail = args['email'] ?? 'example@mail.com';
final String userName = args['name'] ?? 'Шарохин М.С.';

// Список экранов для IndexedStack
final List<Widget> screens = [
_buildVideoCardsTab(),
_buildProfileTab(context, userName, userEmail),
];

return Scaffold(
appBar: AppBar(
title: Text(
_selectedIndex == 0 ? 'ВИДЕОКАРТЫ' : 'ПРОФИЛЬ ПОЛЬЗОВАТЕЛЯ',
style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
),
centerTitle: true,
backgroundColor: Colors.lightGreen,
automaticallyImplyLeading: false, // Отключаем стрелку "Назад" в главном меню
),
body: IndexedStack(
index: _selectedIndex,
children: screens,
),
// Нижняя навигация NavigationBar по спецификации Material 3
bottomNavigationBar: NavigationBar(
selectedIndex: _selectedIndex,
onDestinationSelected: (index) => setState(() => _selectedIndex = index),
backgroundColor: Colors.lightGreen.shade50,
indicatorColor: Colors.lightGreen.shade200,
destinations: const [
NavigationDestination(
icon: Icon(Icons.developer_board_outlined),
selectedIcon: Icon(Icons.developer_board),
label: 'Главная',
),
NavigationDestination(
icon: Icon(Icons.person_outline),
selectedIcon: Icon(Icons.person),
label: 'Профиль',
),
],
),
);
}

// ВКЛАДКА 1: Основной экран видеокарт (с адаптивной версткой)
Widget _buildVideoCardsTab() {
return SingleChildScrollView(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
Container(
padding: const EdgeInsets.all(12.0),
decoration: BoxDecoration(
border: Border.all(color: Colors.grey),
borderRadius: BorderRadius.circular(4.0),
),
child: const Text(
'Графические ускорители (GPU)',
textAlign: TextAlign.center,
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),
),
const SizedBox(height: 16),
// Горизонтальная прокрутка картинок со скруглением
SizedBox(
height: 140,
child: ListView.separated(
scrollDirection: Axis.horizontal,
itemCount: images.length,
separatorBuilder: (context, index) => const SizedBox(width: 12),
itemBuilder: (context, index) {
return ClipRRect(
borderRadius: BorderRadius.circular(12),
child: Image.asset(images[index], width: 200, fit: BoxFit.cover),
);
},
),
),
const SizedBox(height: 24),
const Text('Каталог моделей ускорителей', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
const SizedBox(height: 12),

// АДАПТИВНАЯ ВЕРСТКА: LayoutBuilder переключает ListView на GridView при ширине > 600
LayoutBuilder(
builder: (context, constraints) {
if (constraints.maxWidth > 600) {
// Платформа десктоп / планшет: выводим в два столбца
return GridView.builder(
shrinkWrap: true,
physics: const NeverScrollableScrollPhysics(),
gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2,
crossAxisSpacing: 12,
mainAxisSpacing: 12,
childAspectRatio: 2.8,
),
itemCount: brands.length,
itemBuilder: (context, index) => _buildBrandCard(brands[index]),
);
} else {
// Мобильная платформа: выводим в один столбец стандартным ListView
return ListView.builder(
shrinkWrap: true,
physics: const NeverScrollableScrollPhysics(),
itemCount: brands.length,
itemBuilder: (context, index) => _buildBrandCard(brands[index]),
);
}
},
),
const SizedBox(height: 24),
// Карточка группы студента
Container(
padding: const EdgeInsets.all(12.0),
decoration: BoxDecoration(
border: Border.all(color: Colors.grey),
borderRadius: BorderRadius.circular(4.0),
),
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

// Вспомогательный виджет для построения карточки бренда
Widget _buildBrandCard(Map<String, String> brand) {
return Card(
elevation: 2,
margin: const EdgeInsets.symmetric(vertical: 4.0),
child: ListTile(
leading: const Icon(Icons.memory, color: Colors.lightGreen, size: 32),
title: Text(brand['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
subtitle: Text(brand['description']!, maxLines: 2, overflow: TextOverflow.ellipsis),
trailing: const Icon(Icons.arrow_forward_ios, size: 16),
onTap: () {
// Навигация на экран детализации с передачей данных объекта
Navigator.pushNamed(context, Routes.detail, arguments: brand);
},
),
);
}

// ВКЛАДКА 2: Экран профиля пользователя
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
            // Аватарка по центру
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.lightGreen.shade100,
                child: Icon(Icons.person_outline, size: 60, color: Colors.green.shade800),
              ),
            ),
            const SizedBox(height: 32),
            // Поля ввода с вашей валидацией из 5-й практики
            CustomTextFormField(inputType: InputFieldType.name, labelText: "Ваше имя", hintText: "Имя", prefixIcon: const Icon(Icons.person_outline), controller: pName),
            const SizedBox(height: 16),
            CustomTextFormField(inputType: InputFieldType.email, labelText: "Email", hintText: "email", prefixIcon: const Icon(Icons.email_outlined), controller: pEmail),
            const SizedBox(height: 16),
            CustomTextFormField(inputType: InputFieldType.password, labelText: "Пароль", hintText: "Пароль", prefixIcon: const Icon(Icons.lock_outline), controller: pPass),
            const SizedBox(height: 16),
            CustomTextFormField(inputType: InputFieldType.confirmPassword, labelText: "Повторите пароль", hintText: "Повторите пароль", prefixIcon: const Icon(Icons.lock_clock_outlined), controller: pConfirm, passwordToMatch: pPass),
            const SizedBox(height: 32),
            // Синяя кнопка «Сохранить» по макету
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
            // Сохраненная кнопка выхода
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