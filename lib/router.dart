
import 'package:flutter_kd/screens/login/login_screen.dart';
import 'package:flutter_kd/screens/login/login_viewmodel.dart';
import 'package:flutter_kd/screens/product_list/product_screens.dart';
import 'package:provider/provider.dart';

final appRouter = {
  LoginScreen.routeName: (context) => ChangeNotifierProvider(
    create: (context) => LoginViewModel(context.read(), context.read()),
    child: LoginScreen(),
  ),

  ProductListScreen.routeName: (context) => ProductListScreen(),
};