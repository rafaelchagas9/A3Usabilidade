import 'package:flutter/material.dart';
import 'package:olimpiadas/screens/Auth/register_screen.dart';
import 'package:olimpiadas/utilities/constants.dart';
import 'package:olimpiadas/utilities/custom_icons_icons.dart';

import '../../auth.dart';
import '../homepage/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? _rememberMe = false;
  bool _hidePassword = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  login() {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Preencha o email")));
    } else if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Preencha a senha")));
    } else {
      bool success = false;
      Future<bool> response =
          Auth().login(emailController.text, passwordController.text);
      response.then((value) {
        success = value;
        if (success == false) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Usuário ou senha incorretos")));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
        }
      });
    }
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Email",
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emailController,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                hintText: "Digite seu email",
                hintStyle: kHintTextStyle),
          ),
        )
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Senha",
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            controller: passwordController,
            textAlignVertical: TextAlignVertical.center,
            obscureText: _hidePassword,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                suffixIcon: OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.resolveWith(((states) {
                      if (states.contains(MaterialState.pressed)) {
                      } else {
                        return BorderSide(color: Colors.white.withOpacity(0));
                      }
                    })),
                  ),
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                  child: _hidePassword
                      ? const Icon(
                          CustomIcons.eye,
                          color: Colors.white70,
                        )
                      : const Icon(CustomIcons.eye_slash),
                ),
                hintText: "Digite sua senha",
                hintStyle: kHintTextStyle),
          ),
        )
      ],
    );
  }

  Widget _buildSocialBtn(VoidCallback onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 2), blurRadius: 6.0),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF614AF1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5)
                ],
                stops: [
                  0.1,
                  0.4,
                  0.7,
                  0.9
                ]),
          ),
        ),
        SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
            child: Column(children: <Widget>[
              const Text(
                "Entrar",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30.0),
              _buildEmailField(),
              const SizedBox(height: 30.0),
              _buildPasswordField(),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => print("TODO"),
                  style: kTextBtnStyle,
                  child: const Text("Esqueceu a senha?"),
                ),
              ),
              Row(children: [
                Checkbox(
                  value: _rememberMe,
                  checkColor: Colors.green,
                  activeColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value;
                    });
                  },
                ),
                const Text("Lembrar usuário", style: kLabelStyle)
              ]),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    foregroundColor: Color(0xFF527DAA),
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(15.0),
                  ),
                  onPressed: () => login(),
                  child: const Text(
                    "Entrar",
                    style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    )),
                child: RichText(
                  text: const TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Ainda não tem uma conta? ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: "Registrar",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        )
      ],
    ));
  }
}
