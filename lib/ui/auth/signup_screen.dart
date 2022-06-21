import 'package:flutter/material.dart';
import 'package:flutter_kd/utils/DialogHelper.dart';
import 'package:flutter_kd/ui/auth/login_event.dart';
import 'package:flutter_kd/ui/auth/login_screen.dart';
import 'package:flutter_kd/ui/auth/widget/password_text_field.dart';
import 'package:flutter_kd/ui/auth/widget/primary_btn.dart';
import 'package:provider/provider.dart';

import 'auth_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static const routName = "/signUp";
  static Widget buildScreen(BuildContext context) => ChangeNotifierProvider(
    create: (_) => AuthViewModel(context.read(), context.read()),
    child: const SignUpScreen(),
  );

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late AuthViewModel authViewModel;
  final DialogHelper dialogHelper = DialogHelper();

  @override
  void initState() {
    authViewModel = context.read();
    authViewModel.loading.listen(handleLoading);
    authViewModel.event.listen(onNewEvent);
  }

  void handleLoading(bool isLoading) {
    if (isLoading) {
      dialogHelper.showLoading(context);
    } else {
      dialogHelper.hideLoading();
    }
  }

  void onNewEvent(AuthEvent event) {
    if (event is SignUpSuccess) {
      showCompleteMessage();
    } else if (event is AuthCallFail) {
      DialogHelper.showMessage(context, "Sign up failed");
    }
  }

  void showCompleteMessage() async {
    await DialogHelper.showMessage(context, "SignUp success");
    if (mounted) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
}

  @override
  Widget build(BuildContext context) {
    final isValid = context.select((AuthViewModel viewModel) => viewModel.isValid);
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
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
                    onChanged: authViewModel.onEmailChange,
                  ),
                  SizedBox(height: 10,),
                  PasswordTextField(onChange: authViewModel.onPaswordChange,),
                  SizedBox(height: 10,),
                  PrimaryButton(label: "SignUp", isEnable: isValid, onTap: authViewModel.signup,),
                  SizedBox(height: 10,),
                  PrimaryButton(label: "Login", isEnable: true, onTap: () {
                    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                  },),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
