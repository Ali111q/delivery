import 'package:delivery/controller/delivery_controller.dart';
import 'package:delivery/view/home.dart';
import 'package:delivery/view/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/auth_controller.dart';

void main() {
  runApp(MultiProvider(
    providers: [

      ChangeNotifierProvider<AuthController>(
          create: (context) => AuthController()),
      ChangeNotifierProvider<DeliveryController>(
          create: (context) => DeliveryController()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _end = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Provider.of<AuthController>(context, listen: false)
        .getUserFromShared()
        .then((value) {
          Provider.of<DeliveryController>(context,listen: false).setToken(value);

    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
    theme: ThemeData(
        fontFamily: 'font',
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: createMaterialColor(Color(0xffFF4100)),
      ),
         home: Provider.of<AuthController>(context).user !=null? HomeScreen(): LoginScreen(),

    );
  }
}


MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {
    50: color.withOpacity(strengths[0]),
    100: color.withOpacity(strengths[0]),
    200: color.withOpacity(strengths[0]),
    300: color.withOpacity(strengths[0]),
    400: color.withOpacity(strengths[0]),
    500: color.withOpacity(strengths[0]),
    600: color.withOpacity(strengths[0]),
    700: color.withOpacity(strengths[0]),
    800: color.withOpacity(strengths[0]),
    900: color.withOpacity(strengths[0]),
  };
  return MaterialColor(color.value, swatch);
}
