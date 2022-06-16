import 'package:flutter/material.dart';
import 'package:flutter_kd/router.dart';
import 'package:flutter_kd/ui/login/login_screen.dart';
import 'package:flutter_kd/services/preferences.dart';
import 'package:flutter_kd/services/remote/auth_api.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const KdApp());
}

class KdApp extends StatelessWidget {
  const KdApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(
          create: (_) => SharedPreferences.getInstance(),
          initialData: null,
        ),
        ProxyProvider<SharedPreferences?, Preferences>(
            update: (context, prefs, prev) => Preferences(prefs)
        ),
        Provider(create: (context) => AuthApi())
      ],
      child: MaterialApp(
        initialRoute: LoginScreen.routeName,
        routes: appRouter,
      ),
    );
  }
}
