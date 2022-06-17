import 'package:flutter/material.dart';
import 'package:flutter_kd/router.dart';
import 'package:flutter_kd/services/preferences.dart';
import 'package:flutter_kd/services/remote/auth_api.dart';
import 'package:flutter_kd/ui/auth/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const KdApp());
}

class KdApp extends StatelessWidget {
  const KdApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => Preferences()),
        Provider(create: (context) => AuthApi())
      ],
      child: MaterialApp(
        initialRoute: LoginScreen.routeName,
        routes: appRouter,
      ),
    );
  }
}
