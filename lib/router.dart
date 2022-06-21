import 'package:flutter/material.dart';
import 'package:flutter_kd/ui/screens.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  print("Navigate to ${settings.name}");
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
      return null;
  }
}
