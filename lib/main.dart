import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_form/screen/registration_card.dart';
import 'package:student_form/screen/registration_provider.dart';
import 'package:student_form/screen/registration_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => RegistrationProvider(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
       builder: (context, child) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: child!,
    );
       }
       
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
   Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          body: Center(
            child: provider.showRegistration
                ? RegistrationScreen()  
                : RegistrationCard(),  
          ),
        );
      },
    );
  }
}
