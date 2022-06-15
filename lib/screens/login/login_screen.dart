import 'package:flutter/material.dart';
import 'package:flutter_kd/screens/login/login_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginViewModel loginViewModel;
  var _passwordVisible = true;


  @override
  void initState() {
    loginViewModel = context.read();
  }

  void togglePasswordVisible() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isValid = context.select((LoginViewModel viewModel) => viewModel.isValid);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          const Expanded(
            flex: 1,
            child: Center(
                child: Text("KD"),

            ),
          ),
          Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: "example@gmail.com",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: loginViewModel.onEmailChange,
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      obscureText: _passwordVisible,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            togglePasswordVisible();
                          },
                          child: Icon(_passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      onChanged: loginViewModel.onPaswordChange,
                    ),
                    SizedBox(height: 20,),
                    TextButton(
                      onPressed: loginViewModel.login,
                      style: TextButton.styleFrom(
                        primary: isValid ? Colors.blue : Colors.grey,
                        backgroundColor: isValid ? Colors.blue : Colors.grey,
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}
