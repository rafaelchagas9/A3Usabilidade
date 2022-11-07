import 'package:flutter/material.dart';
import 'package:olimpiadas/screens/Auth/login_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: LoginScreen(),
      ),
    ),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TESTE"),
        backgroundColor: Colors.amber,
      ),
      body: const Center(
        child: Text(
          "123",
          style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.amberAccent,
        child: const Text("Click"),
      ),
    );
  }
}
