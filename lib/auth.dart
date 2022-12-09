import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olimpiadas/screens/Auth/login_screen.dart';
import 'package:olimpiadas/screens/homepage/homeScreen.dart';
import 'package:olimpiadas/utilities/constants.dart';
import 'package:olimpiadas/utilities/custom_icons_icons.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<void> register(String? name, String? emailAddress, String? password,
      File? profilePicture) async {
    if (emailAddress == null || password == null) {
      print("Vazio");
    } else {
      try {
        String profilePictureUrl;
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailAddress,
              password: password,
            )
            .then((value) => {
                  if (profilePicture != null)
                    {
                      profilePictureUrl = uploadImageToFirebase(
                          profilePicture, value.user!.uid),
                      if (profilePictureUrl == '')
                        {}
                      else
                        {value.user!.updatePhotoURL(profilePicture.path)},
                    },
                  value.user!..updateDisplayName(name),
                });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<bool> login(String? emailAddress, String? password) async {
    if (emailAddress == null || password == null) {
      print("Vazio");
    } else {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailAddress, password: password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          return false;
        } else if (e.code == 'wrong-password') {
          return false;
        }
        return false;
      }
    }
    return true;
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  String uploadImageToFirebase(File profilePicture, String uid) {
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('profilePicture/$uid');
    UploadTask uploadTask = firebaseStorageRef.putFile(profilePicture);
    uploadTask.whenComplete(() async {
      print('File Uploaded');
      final String downloadUrl = await firebaseStorageRef.getDownloadURL();
      print(downloadUrl);
      return downloadUrl;
    }).catchError((onError) {
      print(onError);
    });
    return '';
  }
}
