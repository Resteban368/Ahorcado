// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hangman/game/app_sounds.dart';
import 'package:hangman/theme/box_decoration.dart';
import 'package:hangman/widgets/appBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    //controller de texto
    final controller = TextEditingController();
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: decoration,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppBar_widget(
                title: '',
                rutaGoBack: '/',
              ),
              Image.asset(
                'assets/gallow.png',
                fit: BoxFit.cover,
                width: 300,
                height: 300,
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Nombre',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),

                    //color cuando esta activo
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (controller.text.isEmpty) {
                    return;
                  } else {
                    await AppSounds().startSound();
                    GoRouter.of(context).go('/game', extra: {
                      'name': controller.text,
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade900,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 57,
                    ),
                    textStyle: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold)),
                child: const Text('JUGAR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
