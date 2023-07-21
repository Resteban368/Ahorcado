// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBar_widget extends StatelessWidget {
  const AppBar_widget({
    super.key,
    required this.title,
    required this.rutaGoBack,
  });

  final String title;
  final String rutaGoBack;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      padding: const EdgeInsets.only(top: 40),
      width: size.width,
      height: size.height * 0.15,
      decoration: const BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        //sombras

        //color de borde fosforescente morado
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //flecha para regresar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                //regresar a la pantalla anterior
                context.go(rutaGoBack);
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              iconSize: 30,
              color: Colors.white,
            ),
          ),

          //texto de la pantalla de High Scores
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
