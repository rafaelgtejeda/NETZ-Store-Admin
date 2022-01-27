import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netzstore/pages/base_page.dart';
import 'package:netzstore/pages/home_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:netzstore/pages/login_page.dart';
import 'package:netzstore/providers/categories_provider.dart';
import 'package:netzstore/providers/loader_provider.dart';
import 'package:netzstore/providers/searchbar_provider.dart';
import 'package:netzstore/services/localization_services.dart';
import 'package:netzstore/services/shared_service.dart';
import 'package:provider/provider.dart';

import 'pages/categories/categories_list.dart';

Widget _defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _result = await SharedService.isLoggedIn();
  if (_result) {
     _defaultHome = const HomePage();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: (context) => CategoriesProvider(),
          child: const CategoriesList(),
        ),

        ChangeNotifierProvider(
          create: (context) => SearchBarProvider(),
          child: const BasePage(),
        ),

        ChangeNotifierProvider(
          create: (context) => LoaderProvider(),
          child: const BasePage(),
        )

      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NETZ Store',
        translations: LocalizationService(),
        locale: const Locale('pt', 'BR'),
        fallbackLocale: const Locale('pt', 'BR'),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
            duration: 3000,
            curve: Curves.easeInOutExpo,
            splash: "assets/images/store.png",
            splashIconSize: 250.0,
            nextScreen:  _defaultHome,
            splashTransition: SplashTransition.fadeTransition,          
            backgroundColor: Colors.white
          ),
      ),
    );
    
  }
}
