import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import 'register_page.dart';
import 'profile_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            userEmail: _emailController.text,
            userName: "Шарохин М.С.",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход в аккаунт', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                'Добро пожаловать!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.green.shade800),
              ),
              const SizedBox(height: 8),
              const Text(
                'Войдите, чтобы управлять базой видеокарт',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              CustomTextFormField(
                inputType: InputFieldType.email,
                labelText: "Email",
                hintText: "example@mail.com",
                prefixIcon: const Icon(Icons.email_outlined, color: Colors.lightGreen),
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                inputType: InputFieldType.password,
                labelText: "Пароль",
                hintText: "Введите ваш пароль",
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.lightGreen),
                controller: _passwordController,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Войти', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                },
                child: Text('Нет аккаунта? Зарегистрируйтесь', style: TextStyle(color: Colors.green.shade800)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
