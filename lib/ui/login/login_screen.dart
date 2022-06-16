import 'package:flutter/material.dart';
import 'package:flutter_kd/services/remote/api_exception.dart';
import 'package:flutter_kd/ui/DialogHelper.dart';
import 'package:flutter_kd/ui/login/login_viewmodel.dart';
import 'package:flutter_kd/utils/string_ext.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginViewModel loginViewModel;
  var _passwordVisible = true;
  final _dialogHelper = DialogHelper();

  @override
  void initState() {
    loginViewModel = context.read();
    loginViewModel.loading.listen(handleLoading);
    loginViewModel.error.listen(onError);
  }

  void onError(Exception exception) {
    var message = "Somethings went wrong!";
    if (exception is ApiException) {
      if (!exception.message.isNullOrEmpty()) {
        message = exception.message!;
      }
    }

    _dialogHelper.hideLoading();
    DialogHelper.showMessage(context, message);
  }

  // TODO: resolve dismiss specific dialog
  void handleLoading(bool isLoading) {
    if (isLoading) {
      _dialogHelper.showLoading(context);
    } else {
      // _dialogHelper.hideLoading();
    }
  }

  @override
  void dispose() {
    loginViewModel.dispose();
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
                child: Text(
                  "KD",
                  style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                ),
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
                        minimumSize: Size(double.infinity, 60),
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
