import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olimpiadas/screens/Auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:olimpiadas/screens/homepage/home.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Falha ao realizar login"),
              );
            } else if (snapshot.hasData) {
              return HomePage();
            } else {
              return LoginScreen();
            }
          }),
        ),
      ),
    ),
  );
}
