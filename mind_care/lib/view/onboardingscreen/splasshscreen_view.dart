import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mind_care/view/login_view.dart';

class onBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.indigo.shade700,
                  Colors.indigo.shade200,
                  Colors.indigoAccent.shade200,
                ],
              ),
            ),
          ),
          Container(),
          Positioned(
            bottom: 0,
            left: -10,
            right: -10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.9),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(
                    2000,
                  ),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 300),
                  FractionallySizedBox(
                    widthFactor: .6,
                    child: FilledButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStatePropertyAll(
                                Colors.blueGrey.shade400)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text("GET STARTED")),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Lottie.asset('lottie/yoga2.json'),
          ),
        ],
      ),
    );
  }
}
