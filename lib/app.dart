import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/home/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo.shade200),
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: const HomeView(),
    );
  }
}
