import 'package:flutter/material.dart';
import 'package:flutter_kd/services/remote/model/product.dart';
import 'package:flutter_kd/ui/auth/auth_view_model.dart';
import 'package:flutter_kd/ui/auth/login_screen.dart';
import 'package:flutter_kd/ui/auth/signup_screen.dart';
import 'package:flutter_kd/ui/product_detail_screen.dart';
import 'package:flutter_kd/ui/product_detail_vm.dart';
import 'package:flutter_kd/ui/product_list/product_screens.dart';
import 'package:flutter_kd/ui/product_list/products_vm.dart';
import 'package:provider/provider.dart';

Map<String, Widget Function(BuildContext)> appRouter = {
  LoginScreen.routeName: (_) => ChangeNotifierProvider(
        create: (context) => AuthViewModel(context.read(), context.read()),
        child: const LoginScreen(),
      ),
  SignUpScreen.routName: (context) => ChangeNotifierProvider(
        create: (context) => AuthViewModel(context.read(), context.read()),
        child: const SignUpScreen(),
      ),
  ProductListScreen.routeName: (context) => ChangeNotifierProvider(
        create: (context) => ProductVM(context.read()),
        child: const ProductListScreen(),
      ),

  ProductDetailScreen.routeName: (context) => ChangeNotifierProvider(
    create: (_) {
      Object? args = ModalRoute.of(context)?.settings.arguments;
      Product? product = args == null ? null : args as Product;
      return ProductDetailVM(context.read(), product);
    },
    child: ProductDetailScreen(),
  )
};

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: LoginScreen.buildScreen);
    case SignUpScreen.routName:
      return MaterialPageRoute(builder: SignUpScreen.buildScreen);
    case ProductListScreen.routeName:
      return MaterialPageRoute(builder: ProductListScreen.buildScreen);
    case ProductDetailScreen.routeName:
      return MaterialPageRoute(builder: (context) => ProductDetailScreen.buildScreen(context, settings));
    default:
      return MaterialPageRoute(builder: LoginScreen.buildScreen);
  }
}
