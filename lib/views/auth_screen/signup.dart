// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app_using_bloc/views/auth_screen/login.dart';

import '../../models/music_model.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Signup"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                  hintText: 'Email', border: UnderlineInputBorder()),
            ),
            TextFormField(
              controller: password,
              decoration: const InputDecoration(
                  hintText: 'Password', border: UnderlineInputBorder()),
            ),
            SizedBox(
              height: 25.h,
            ),
            Center(
              child: ElevatedButton(
                child: Text(
                  "Click to Signup",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
                onPressed: () {
                  signupWithEmailAndPassword(
                      context: context,
                      email: email.text,
                      password: password.text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  signupWithEmailAndPassword(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      Get.dialog(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AlertDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent.withOpacity(0.1),
            content: Center(
                child: CircularProgressIndicator.adaptive(
              backgroundColor: Theme.of(context).colorScheme.onSecondary,
            )),
          ),
        ],
      ));
      log("1");

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: 'dev@gmail.com', password: '1234567');
      log("2");

      String uid = userCredential.user!.uid;

      log(uid.toString());

      final MusicModel musicModel = MusicModel(
          instrumental: [],
          ambients: [],
          nature: [],
          traditional: [],
          guided: [],
          binaural: [],
          chants: [],
          mindfulness: [],
          yoga: [],
          solfeggio: [],
          gentle: [],
          peacefull: [],
          sunrise: [],
          soft: [],
          heaven: []);

      await FirebaseFirestore.instance
          .collection("music")
          .doc(uid)
          .set(
            musicModel.toJson(),
          )
          // .then((value) => updateUser(newUser: newUser))
          // .then((value) => userProvider.updateUser(newUser))
          // .then((value) => userProvider.updateFirebaseUser(
          //       FirebaseAuth.instance.currentUser!,
          //     ))
          // .then((value) => isLoading.value = false)
          .then(
            (value) => Get.offAll(() => OneClicLogin(),
                transition: Transition.rightToLeftWithFade,
                duration: const Duration(milliseconds: 500)),
          );

      // Get.off(() => MusicPlayer());
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(GetSnackBar(
        duration: const Duration(seconds: 6),
        message: e.toString(),
      ));
    } catch (e) {
      Get.back();

      Get.showSnackbar(GetSnackBar(
        duration: const Duration(seconds: 6),
        message: e.toString(),
      ));
    }
  }
}
