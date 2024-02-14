import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_orders_project/core/logic/cache_helper.dart';
import 'package:vegetable_orders_project/core/logic/helper_methods.dart';
import 'package:vegetable_orders_project/views/home/home_view.dart';
import '../login/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() async {
    Timer(const Duration(seconds: 3), () {
      navigateTo(
        isRemove: true,
        toPage: CacheHelper.isAuth() ? const HomeView() : const LoginView(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.directional(
              textDirection: TextDirection.ltr,
              bottom: -53,
              start: 27,
              child: Image.asset(
                "assets/images/splash_ib.png",
                width: 448,
                height: 298,
              )),
          Image.asset(
            "assets/images/splash_bg.png",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Center(
            child: FlipInY(
              delay: const Duration(seconds: 1),
              duration: const Duration(seconds: 2),
              child: ZoomIn(
                delay: const Duration(seconds: 1),
                duration: const Duration(seconds: 1),
                child: Image.asset(
                  "assets/images/vegetable_basket.png",
                  width: 160,
                  height: 157,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
