import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:olimpiadas/screens/Auth/login_screen.dart';
import 'package:olimpiadas/utilities/custom_icons_icons.dart';

import '../../auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 30, left: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 50,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(FirebaseAuth
                                .instance.currentUser!.photoURL ==
                            null
                        ? "https://cdn.onlinewebfonts.com/svg/img_329115.png"
                        : FirebaseAuth.instance.currentUser!.photoURL!),
                  ),
                ),
                Text(FirebaseAuth.instance.currentUser!.displayName == null
                    ? "Usuário não logado"
                    : "Olá, ${FirebaseAuth.instance.currentUser!.displayName}"),
                TextButton(
                  child: Text("Sair"),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      extendBody: true,
    );
  }
}
