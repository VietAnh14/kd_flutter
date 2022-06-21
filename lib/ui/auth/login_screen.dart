import 'package:flutter/material.dart';
import 'package:flutter_kd/services/remote/api_exception.dart';
import 'package:flutter_kd/ui/DialogHelper.dart';
import 'package:flutter_kd/ui/auth/login_event.dart';
import 'package:flutter_kd/ui/auth/widget/primary_btn.dart';
import 'package:flutter_kd/ui/auth/signup_screen.dart';
import 'package:flutter_kd/ui/auth/widget/password_text_field.dart';
import 'package:flutter_kd/ui/product_list/product_screens.dart';
import 'package:flutter_kd/utils/string_ext.dart';
import 'package:provider/provider.dart';

import '../auth/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  static Widget buildScreen(BuildContext context) => ChangeNotifierProvider(
    create: (_) => AuthViewModel(context.read(), context.read()),
    child: const LoginScreen(),
  );

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthViewModel authViewModel;
  var _passwordVisible = true;
  final _dialogHelper = DialogHelper();

  @override
  void initState() {
    authViewModel = context.read();
    authViewModel.loading.listen(handleLoading);
    authViewModel.error.listen(onError);
    authViewModel.event.listen(onNewEvent);
  }

  void onNewEvent(AuthEvent event) {
    if (event is LoginSuccess) {
      Navigator.pushReplacementNamed(context, ProductListScreen.routeName);
    }
  }

  void onError(dynamic exception) {
    var message = "Somethings went wrong!";
    if (exception is ApiException) {
      if (!exception.message.isNullOrEmpty()) {
        message = exception.message!;
      }
    }

    DialogHelper.showMessage(context, message);
  }

  // TODO: resolve dismiss specific dialog
  void handleLoading(bool isLoading) {
    if (isLoading) {
      _dialogHelper.showLoading(context);
    } else {
      _dialogHelper.hideLoading();
    }
  }


  @override
  void didChangeDependencies() {
    print("did change dependencies");
  }


  void togglePasswordVisible() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isValid = context.select((AuthViewModel viewModel) => viewModel.isValid);
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
                      onChanged: authViewModel.onEmailChange,
                    ),
                    SizedBox(height: 10,),
                    PasswordTextField(onChange: authViewModel.onPaswordChange,),
                    SizedBox(height: 10,),
                    PrimaryButton(label: "Login", isEnable: isValid, onTap: authViewModel.login,),
                    SizedBox(height: 10,),
                    PrimaryButton(label: "SignUp", isEnable: true, onTap: () {
                      Navigator.pushReplacementNamed(context, SignUpScreen.routName);
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
