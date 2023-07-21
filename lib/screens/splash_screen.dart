// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hangman/game/app_sounds.dart';

import '../theme/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
        body: Container(
            width: size.width,
            height: size.height,
            decoration: decoration,
            child: Center(
              child: SizedBox(
                width: size.width * 0.8,
                height: size.height * 0.8,
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/gallow.png',
                      fit: BoxFit.cover,
                      width: 300,
                      height: 300,
                    ),

                    BounceInDown(
                      duration: const Duration(seconds: 1),
                      child: const Text(
                        'AHORCADO',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    BounceInDown(
                      duration: const Duration(seconds: 1),
                      child: Text(
                        'El juego de las palabras',
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    const Spacer(),

                    //ponemos dos botones
                    ElevatedButton(
                      onPressed: () async {
                        await AppSounds().goodSound();
                        context.go('/home');
                      },
                      style: styleButton,
                      child: const Text('EMPEZAR'),
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        context.go('/score');
                      },
                      style: styleButton,
                      child: const Text('PUNTAJES'),
                    ),
                    const Spacer(),
                    BounceInDown(
                      duration: const Duration(seconds: 1),
                      child: Text(
                        'Desarrollado por Baneste Codes',
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
