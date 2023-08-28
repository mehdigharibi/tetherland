import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/homePage.dart';
import 'service/apiProvider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (contex) => apiProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: homePage(),
    );
  }
}
