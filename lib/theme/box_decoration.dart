import 'package:flutter/material.dart';

final decoration = BoxDecoration(
  //poner un gradiente de arriba a abajo
  gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        //los colores que sean morados
        Colors.purple.shade900,
        Colors.purple.shade800,
        Colors.purple.shade700,
        Colors.purple.shade600,
        Colors.purple.shade500,
        Colors.purple.shade400,
      ]),
);
