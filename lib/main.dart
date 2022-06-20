import 'package:flutter/material.dart';
import 'package:flutter_kd/router.dart';
import 'package:flutter_kd/services/preferences.dart';
import 'package:flutter_kd/services/remote/auth_api.dart';
import 'package:flutter_kd/services/remote/product_api.dart';
import 'package:flutter_kd/ui/auth/auth_view_model.dart';
import 'package:flutter_kd/ui/auth/login_screen.dart';
import 'package:flutter_kd/ui/product_list/product_screens.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const KdApp());
}

class KdApp extends StatelessWidget {
  const KdApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //TODO: Wait for preferences to complete init
      providers: [
        Provider(create: (context) => Preferences()),
        Provider(create: (context) => AuthApi()),
        Provider(create: (context) => ProductApi(context.read())),
      ],
      child: MaterialApp(
        initialRoute: ProductListScreen.routeName,
        routes: appRouter,
      ),
    );
  }
}
