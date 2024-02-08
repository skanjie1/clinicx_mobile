import 'package:clinicx_patient/providers/location_provider.dart';
import 'package:clinicx_patient/screens/home/home_screen.dart';
import 'package:clinicx_patient/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class InitialLoadingScreen extends StatefulWidget {
  const InitialLoadingScreen({super.key});

  @override
  State<InitialLoadingScreen> createState() => _InitialLoadingScreenState();
}

class _InitialLoadingScreenState extends State<InitialLoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      await Provider.of<LocationProvider>(context, listen: false)
          .getCurrentLocation();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Homescreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dDarkBlue,
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/logo.png",
                      width: 150,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Lottie.asset(
                    "assets/city.json",
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 32),
            color: dDarkBlue,
            child: Row(children: [
              Lottie.asset(
                "assets/ripple.json",
                width: 80,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Loading...",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Getting things ready for you",
                    style: TextStyle(color: Colors.grey[50]),
                  )
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }
}
