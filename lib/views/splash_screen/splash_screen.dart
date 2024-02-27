import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/music_model.dart';
import '../views.dart';
import '../music/playerControllerStates.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  MusicModel? musicData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    Future.delayed(const Duration(seconds: 2), () async {
      fetchData();
    });
    fetchData().then((data) {
      Get.off(() => HomeScreen(
            musicModel: data,
          ));
    });
  }

  Future<MusicModel?> fetchData() async {
    try {
      log("came to fetch");
      final DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('music')
          .doc(
              '8susjltyDBVV299DHHC3d1lVt5w1') // Replace with the actual document ID
          .get();

      log("Checking Document...");
      if (document.exists) {
        log("Document existed");

        final Map<String, dynamic>? data =
            document.data() as Map<String, dynamic>?;

        if (data != null) {
          log("data not null");
          return MusicModel.fromJson(data);
        }
      }

      return null; // Document doesn't exist or has null data
    } catch (e) {
      log("Error fetching data: $e");
      return null;
      // Handle the error based on your error handling strategy
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      // The app is in the foreground
    } else if (state == AppLifecycleState.paused) {
      // The app is in the background
    } else if (state == AppLifecycleState.inactive) {
      // The app is inactive (probably in a transition state)
    } else if (state == AppLifecycleState.detached) {
      // The app is completely detached (closed)
      // Perform your exit actions here
      // For example, save data, log events, etc.
      log("App is detached (closed), perform exit actions here.");

      var controller = Get.put(PlayerController());

      controller.stopAudio();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset('assets/app_logo.gif'),
        ));
  }
}
