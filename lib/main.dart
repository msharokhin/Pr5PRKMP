import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Импорт пакета
import 'routes.dart';
import 'pages/bloc/video_cards_bloc.dart'; // Импорт BLoC
import 'pages/loading_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BLoC Архитектура — Видеокарты',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      initialRoute: Routes.loading,
      routes: {
        Routes.loading: (context) => const LoadingPage(),
        Routes.login: (context) => const LoginPage(),
        Routes.signup: (context) => const RegisterPage(),
        // ИЗМЕНЕНИЕ: Оборачиваем HomePage в BlocProvider и сразу добавляем событие в поток
        Routes.home: (context) => BlocProvider(
          create: (context) => VideoCardsBloc()..add(const LoadVideoCardsEvent()),
          child: const HomePage(),
        ),
        Routes.detail: (context) => const DetailPage(),
      },
    );
  }
}
