import 'package:crypto_tracker_flutter/screens/price_screen.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: InputBorder.none,
      ),
      scaffoldBackgroundColor: const Color.fromRGBO(23, 23, 52, 1),
      appBarTheme: const AppBarTheme(color: Color.fromRGBO(23, 23, 52, 1),),
      ),
      home: PriceScreen(),
    );
  }
}
