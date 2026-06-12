import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:llb_task/controller/localisation_controller.dart';
import 'package:llb_task/helper/routes_helper.dart';
import 'package:llb_task/utils/images.dart';
import 'package:llb_task/view/base/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();

    _initialize();

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      _,
    ) {
      _handleConnectivityChange();
    });
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));

    bool hasInternet = await InternetConnection().hasInternetAccess;

    if (hasInternet) {
      _navigateToHome();
    } else {
      _showNoInternetSnackBar();
    }
  }

  Future<void> _handleConnectivityChange() async {
    bool hasInternet = await InternetConnection().hasInternetAccess;

    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (hasInternet) {
      _navigateToHome();
    } else {
      _showNoInternetSnackBar();
    }
  }

  void _showNoInternetSnackBar() {
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(days: 1),
        content: Text('No internet available', textAlign: TextAlign.center),
      ),
    );
  }

  Future<void> _navigateToHome() async {
    if (_isNavigating) return;

    _isNavigating = true;

    await Get.find<LocalizationController>().initSharedData();

    if (!mounted) return;

    Get.offNamed(RoutesHelper.gethomeScreenRoute());
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(Images.logo, width: 250, height: 250),
            ),
          ),
          const Positioned(bottom: 50, child: CustomLoader()),
        ],
      ),
    );
  }
}
