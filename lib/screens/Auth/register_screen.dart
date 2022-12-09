import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olimpiadas/screens/Auth/login_screen.dart';
import 'package:olimpiadas/utilities/constants.dart';
import 'package:olimpiadas/utilities/custom_icons_icons.dart';

import '../../auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  File? profilePicture;

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  bool _screenUpdate = false;

  Future _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      profilePicture = imageTemporary;
    });
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
          height: 50.0,
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

  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Confirmar Senha",
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            controller: confirmPasswordController,
            textAlignVertical: TextAlignVertical.center,
            obscureText: _hideConfirmPassword,
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
                      _hideConfirmPassword = !_hideConfirmPassword;
                    });
                  },
                  child: _hideConfirmPassword
                      ? const Icon(
                          CustomIcons.eye,
                          color: Colors.white70,
                        )
                      : const Icon(CustomIcons.eye_slash),
                ),
                hintText: "Confirme a senha",
                hintStyle: kHintTextStyle),
          ),
        )
      ],
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Nome",
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            controller: nameController,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
            decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.abc,
                  color: Colors.white,
                ),
                hintText: "Insira seu nome",
                hintStyle: kHintTextStyle),
          ),
        )
      ],
    );
  }

  Widget _buildPhotoField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 150,
          height: 150,
          child: IconButton(
            onPressed: () => _pickImage(),
            icon: CircleAvatar(
              radius: 100,
              backgroundImage: profilePicture != null
                  ? FileImage(profilePicture!) as ImageProvider
                  : const CachedNetworkImageProvider(
                      "https://cdn.onlinewebfonts.com/svg/img_329115.png"),
            ),
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
                "Registrar",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30.0),
              _buildPhotoField(),
              const SizedBox(height: 30.0),
              _buildNameField(),
              const SizedBox(height: 30.0),
              _buildEmailField(),
              const SizedBox(height: 30.0),
              _buildPasswordField(),
              const SizedBox(height: 30.0),
              _buildConfirmPasswordField(),
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
                  onPressed: () => {
                    Auth()
                        .register(nameController.text, emailController.text,
                            passwordController.text, profilePicture)
                        .then((value) => Navigator.pop(context)),
                  },
                  child: const Text(
                    "Registrar",
                    style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans'),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: RichText(
                  text: const TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Já tem uma conta? ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: "Entrar",
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
