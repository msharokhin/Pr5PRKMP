import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import 'profile_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            userEmail: _emailController.text,
            userName: _nameController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Создание аккаунта',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green.shade800),
              ),
              const SizedBox(height: 30),
              CustomTextFormField(
                inputType: InputFieldType.name,
                labelText: "ФИО",
                hintText: "Шарохин Михаил Сергеевич",
                prefixIcon: const Icon(Icons.person_outline, color: Colors.lightGreen),
                controller: _nameController,
              ),
              const SizedBox(height: 16),
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
                hintText: "Минимум 6 симв., цифра и знаки +_-",
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.lightGreen),
                controller: _passwordController,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                inputType: InputFieldType.confirmPassword,
                labelText: "Повторите пароль",
                hintText: "Введите пароль еще раз",
                prefixIcon: const Icon(Icons.lock_clock_outlined, color: Colors.lightGreen),
                controller: _confirmPasswordController,
                passwordToMatch: _passwordController,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Зарегистрироваться', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
