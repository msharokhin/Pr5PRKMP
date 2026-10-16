import 'package:flutter/material.dart';

enum InputFieldType { name, email, password, confirmPassword }

class CustomTextFormField extends StatefulWidget {
  final InputFieldType inputType;
  final String labelText;
  final String hintText;
  final Widget prefixIcon;
  final TextEditingController controller;
  final TextEditingController? passwordToMatch;

  const CustomTextFormField({
    super.key,
    required this.inputType,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.passwordToMatch,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _hidePassword = true;

  String? _validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Поле не может быть пустым";
    }

    switch (widget.inputType) {
      case InputFieldType.name:
        final reg = RegExp(r'^[A-Za-zА-Яа-я\s]+$');
        if (!reg.hasMatch(value)) {
          return "Имя должно содержать только буквы и пробелы";
        }
        return null;

      case InputFieldType.email:
        final reg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!reg.hasMatch(value)) {
          return "Введите корректный Email (содержащий @ и точку)";
        }
        return null;

      case InputFieldType.password:
        if (value.length < 6) {
          return "Пароль должен быть не менее 6 символов";
        }
        final hasLetter = RegExp(r'[A-Za-zА-Яа-я]').hasMatch(value);
        final hasDigit = RegExp(r'\d').hasMatch(value);
        final hasSpecial = RegExp(r'[+_\-]').hasMatch(value);
        if (!hasLetter || !hasDigit || !hasSpecial) {
          return "Пароль должен содержать буквы, цифры и символы (+, _, -)";
        }
        return null;

      case InputFieldType.confirmPassword:
        if (widget.passwordToMatch != null && value != widget.passwordToMatch!.text) {
          return "Пароли не совпадают";
        }
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.inputType == InputFieldType.password ||
        widget.inputType == InputFieldType.confirmPassword;

    return TextFormField(
      controller: widget.controller,
      obscureText: isPassword && _hidePassword,
      textInputAction: widget.inputType == InputFieldType.confirmPassword
          ? TextInputAction.done
          : TextInputAction.next,
      keyboardType: widget.inputType == InputFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,
      onFieldSubmitted: (_) {
        if (widget.inputType != InputFieldType.confirmPassword) {
          FocusScope.of(context).nextFocus();
        }
      },
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(_hidePassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () => setState(() => _hidePassword = !_hidePassword),
        )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.lightGreen, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green.shade800, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: _validator,
    );
  }
}
