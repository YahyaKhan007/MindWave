// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app_using_bloc/models/music_model.dart';
import 'package:music_app_using_bloc/views/homescreen/homescreen.dart';

import '../Utils/utils.dart';

class OneClicLogin extends StatelessWidget {
  final MusicModel? musicModel;
  OneClicLogin({super.key, this.musicModel});
  FocusNode passsNode = FocusNode();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        toolbarHeight: 60.h,
        centerTitle: true,
        title: Text(
          "Login as DEV",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 17.sp, letterSpacing: -1),
        ),
        leading: Container(
          margin: EdgeInsets.only(left: 10.w),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: theme.brightness == Brightness.dark
                  ? AppShadows.blackThemeShadow
                  : AppShadows.lightThemeShadow),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              backgroundColor: theme.colorScheme.surface,
              child: Icon(
                Icons.arrow_back,
                color: theme.colorScheme.onSurface,
                size: 20.r,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              decoration: BoxDecoration(
                  boxShadow: theme.brightness == Brightness.light
                      ? AppShadows.lightThemeShadow
                      : AppShadows.blackThemeShadow,
                  borderRadius: BorderRadius.circular(15.r),
                  color: theme.colorScheme.surface),
              child: TextFormField(
                focusNode: passsNode,
                controller: password,
                cursorColor: theme.colorScheme.onSurface,
                decoration: const InputDecoration(
                    hintText: 'Password', border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 35.h,
            ),
            InkWell(
              onTap: () {
                passsNode.unfocus;
                // var credential = await
                _loginWithEmailAndPassword(
                    context: context, password: password.text);

                // if (credential != null) {
                //   BlocListener<PlaySongBloc, PlaySongState>(
                //       listener: ((context, state) {
                //     return Get.offAll(() => Login());
                //   }));
                // }
              },
              child: Center(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  decoration: BoxDecoration(
                      boxShadow: theme.brightness == Brightness.light
                          ? AppShadows.lightThemeShadow
                          : AppShadows.blackThemeShadow,
                      borderRadius: BorderRadius.circular(15.r),
                      color: theme.colorScheme.surface),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loginWithEmailAndPassword(
      {required BuildContext context, required String password}) async {
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
      log('1');
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: 'dev@gmail.com', password: password);
      log('2');

      log(userCredential.toString());

      Get.offAll(() => HomeScreen(
            musicModel: musicModel,
          ));
      // return userCredential;
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(GetSnackBar(
        duration: const Duration(seconds: 6),
        message: e.toString(),
      ));
      // return null;
    } catch (e) {
      Get.back();

      Get.showSnackbar(GetSnackBar(
        duration: const Duration(seconds: 6),
        message: e.toString(),
      ));
      // return null;
    }
  }

  showSnackbar(BuildContext context) {
    Get.snackbar(
      'Logged In',
      "You have been Logged In As Developer",
      backgroundColor: Theme.of(context).colorScheme.background,
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.TOP,
      colorText: Theme.of(context).colorScheme.onSurface,
    );
  }
}
