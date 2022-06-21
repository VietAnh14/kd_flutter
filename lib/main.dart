import 'package:flutter/material.dart';
import 'package:flutter_kd/router.dart';
import 'package:flutter_kd/services/preferences.dart';
import 'package:flutter_kd/services/remote/auth_api.dart';
import 'package:flutter_kd/services/remote/product_api.dart';
import 'package:provider/provider.dart';
import 'package:flutter_kd/ui/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = Preferences();
  await preferences.init();
  runApp(KdApp(preferences: preferences,));
}

class KdApp extends StatelessWidget {
  final Preferences preferences;
  const KdApp({Key? key, required this.preferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: preferences),
        Provider(create: (context) => AuthApi()),
        Provider(create: (context) => ProductApi(context.read())),
      ],
      //https://api.flutter.dev/flutter/material/MaterialApp/initialRoute.html
      //Even if the route was just /a, the app would start with / and /a loaded
      child: MaterialApp(
        initialRoute: preferences.isAuth ? ProductListScreen.routeName : LoginScreen.routeName,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
