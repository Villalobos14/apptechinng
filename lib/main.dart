import 'package:flutter/material.dart';
import 'package:techinng/features/onboarding/presentation/pages/onboarding_screen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Soft Skills App',
        theme: ThemeData(
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            primary: Colors.black,
            background: Colors.white,
            brightness: Brightness.light,
          ),
          useMaterial3: false,
        ),
        home: const OnboardingScreen(),
        routes: {
        },
      );
}
