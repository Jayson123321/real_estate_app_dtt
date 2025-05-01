import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:real_estate_app_dtt/screens/HouseListScreen.dart';
import 'package:real_estate_app_dtt/screens/SplashScreen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(RealEstateApp());
}

class RealEstateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DTT Real Estate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/houses': (context) => HouseListScreen(),
      },
    );
  }
}
