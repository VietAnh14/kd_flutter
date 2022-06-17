import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({Key? key, this.onChange}) : super(key: key);

  final Function(String)? onChange;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  var _obscureText = true;

  void togglePasswordVisible() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: "Password",
        border: OutlineInputBorder(),
        suffixIcon: GestureDetector(
          onTap: () {
            togglePasswordVisible();
          },
          child: Icon(_obscureText
              ? Icons.visibility_off
              : Icons.visibility),
        ),
      ),
      onChanged: widget.onChange,
    );
  }
}
