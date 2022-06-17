import 'package:flutter_kd/ui/auth/auth_view_model.dart';
import 'package:flutter_kd/ui/auth/login_screen.dart';
import 'package:flutter_kd/ui/auth/signup_screen.dart';
import 'package:flutter_kd/ui/product_list/product_screens.dart';
import 'package:provider/provider.dart';

final appRouter = {
  LoginScreen.routeName: (context) => ChangeNotifierProvider(
        create: (context) => AuthViewModel(context.read(), context.read()),
        child: LoginScreen(),
      ),
  SignUpScreen.routName: (context) => ChangeNotifierProvider(
        create: (context) => AuthViewModel(context.read(), context.read()),
        child: SignUpScreen(),
      ),

  ProductListScreen.routeName: (context) => ProductListScreen(),
};
