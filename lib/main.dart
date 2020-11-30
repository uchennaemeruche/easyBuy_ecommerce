import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/providers/cart.dart';
import 'package:e_commerce_app/routes.dart';
import 'package:e_commerce_app/screens/home/home_screen.dart';
import 'package:e_commerce_app/screens/onboarding/splash_screen.dart';
import 'package:e_commerce_app/screens/screen_wrapper.dart';
import 'package:e_commerce_app/services/auth-services.dart';
import 'package:e_commerce_app/utilities/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

serviceLocator() {
  GetIt.I.registerLazySingleton(() => AuthService());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  serviceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<MyUser>.value(
            value: AuthService().user,
            catchError: (BuildContext context, Object obj) {
              print(
                  "Hello, an error occurred in the Main Widget screen builder $obj");
              return obj;
            },
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => Cart(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme(),
          home: ScreenWrapper(),
          // initialRoute: ScreenWrapper.routeName,
          // initialRoute: Provider.of<MyUser>(context) == null
          //     ? SplashScreen.routeName
          //     : HomeScreen.routeName,
          routes: routes,
        ));
  }
}
