// ignore_for_file: avoid_print, deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hangman/game/app_sounds.dart';
import 'package:hangman/game/hidden_letter.dart';
import 'package:hangman/game/list_letters.dart';
import 'package:hangman/models/score_response.dart';
import 'package:hangman/repository/data_repository.dart';
import 'package:hangman/theme/box_decoration.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

var lives = 3;
var tries = 0;
var score = 0;
List<String> selectedChar = [];
var character = 'abcdefghijklmnñopqrstuvwxyz'.toUpperCase();

//meotod para comprobar si el usuario tiene vidas para seguir jugando
bool usuarioGano(List<String> letrasUsadas, String palabraParaAdivinar) {
  // Convertimos la palabra para adivinar en una lista de letras
  List<String> letrasPalabra = palabraParaAdivinar.split('');

  // Comprobamos si todas las letras de la palabra están en las letras usadas
  bool todasLasLetrasAdivinadas =
      letrasPalabra.every((letra) => letrasUsadas.contains(letra));

  return todasLasLetrasAdivinadas;
}

class _GameScreenState extends State<GameScreen> {
  Map<String, String> palabraYPista = obtenerPalabraYPistaAleatoria();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
        body: Container(
            width: size.width,
            height: size.height,
            decoration: decoration,
            child: Column(
              children: [
                SizedBox(
                    width: size.width,
                    height: size.height * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          width: size.width,
                          height: size.height * 0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 45,
                                  ),
                                  Positioned(
                                    left: 18,
                                    top: 11,
                                    child: Text(
                                      '$lives',
                                      style: GoogleFonts.outfit(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Puntaje: $score',
                                style: GoogleFonts.outfit(
                                    fontSize: 23,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),

                              //icono de bombilla

                              IconButton(
                                  onPressed: () {
                                    AppSounds().helpSound();
                                    //mostramos la pista de la palabra
                                    print(palabraYPista['pista']);
                                    AwesomeDialog(
                                      dismissOnTouchOutside: false,
                                      context: context,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Pista',
                                      desc: palabraYPista['pista']!,
                                      btnOkOnPress: () async {
                                        //cerramos el dialogo
                                      },
                                    ).show();
                                  },
                                  icon: const Icon(
                                    Icons.lightbulb,
                                    color: Colors.amber,
                                    size: 40,
                                  )),

                              //iconod de home
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          'assets/$tries.png',
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: size.width,
                            // height: size.height * 0.14,
                            child: BounceInDown(
                              duration: const Duration(seconds: 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: palabraYPista['palabra']!
                                    .split("")
                                    .map((e) => HiddenLetter(
                                          e,
                                          !selectedChar
                                              .contains(e.toUpperCase()),
                                        ))
                                    .toList(),
                              ),
                            ))
                      ],
                    )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 7,
                    children: List.generate(character.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: ElevatedButton(
                          onPressed: selectedChar
                                  .contains(character[index].toUpperCase())
                              ? null
                              : () {
                                  setState(() {
                                    selectedChar
                                        .add(character[index].toUpperCase());
                                    print(selectedChar);

                                    if (!palabraYPista['palabra']!
                                        .split("")
                                        .contains(
                                            character[index].toUpperCase())) {
                                      print('no contiene');

                                      AppSounds().errorSound();

                                      tries++;
                                      if (tries == 6) {
                                        lives--;

                                        if (lives == 0) {
                                          AppSounds().errorSound();

                                          AwesomeDialog(
                                            dismissOnTouchOutside: false,
                                            context: context,
                                            dialogType: DialogType.ERROR,
                                            animType: AnimType.BOTTOMSLIDE,
                                            title:
                                                'HAS PERDIDO TODAS TUS VIDAS',
                                            btnOkOnPress: () {
                                              //guardamos el puntaje

                                              DataRepository()
                                                  .guardarScoreResponse(
                                                      SocreResponse(
                                                name: widget.name,
                                                score: score,
                                                fecha:
                                                    //la fecha actual pero sin la hora solo la fecha
                                                    formatDate(DateTime.now(), [
                                                  dd,
                                                  '/',
                                                  mm,
                                                  '/',
                                                  yyyy
                                                ]),
                                              ));

                                              tries = 0;
                                              score = 0;
                                              lives = 3;
                                              selectedChar = [];
                                              palabraYPista =
                                                  obtenerPalabraYPistaAleatoria();
                                              context.go('/');
                                            },
                                          ).show();
                                          return;
                                        } else {
                                          AppSounds().gameOverSound();

                                          AwesomeDialog(
                                            dismissOnTouchOutside: false,
                                            context: context,
                                            dialogType: DialogType.ERROR,
                                            animType: AnimType.BOTTOMSLIDE,
                                            title: 'PERDISTE',
                                            desc:
                                                'La palabra era: ${palabraYPista['palabra']}',
                                            btnOkOnPress: () async {
                                              setState(() {
                                                //reiniciamos el juego
                                                tries = 0;
                                                selectedChar = [];
                                                palabraYPista =
                                                    obtenerPalabraYPistaAleatoria();
                                              });
                                            },
                                          ).show();
                                          return;
                                        }
                                      }
                                    } else {
                                      if (usuarioGano(selectedChar,
                                          palabraYPista['palabra']!)) {
                                        AppSounds().successSound();
                                        AwesomeDialog(
                                          dismissOnTouchOutside: false,
                                          context: context,
                                          dialogType: DialogType.SUCCES,
                                          animType: AnimType.BOTTOMSLIDE,
                                          title: 'GANASTE',
                                          btnCancel: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                score++;
                                              });

                                              DataRepository()
                                                  .guardarScoreResponse(
                                                      SocreResponse(
                                                name: widget.name,
                                                score: score,
                                                fecha:
                                                    //la fecha actual pero sin la hora solo la fecha
                                                    formatDate(DateTime.now(), [
                                                  dd,
                                                  '/',
                                                  mm,
                                                  '/',
                                                  yyyy
                                                ]),
                                              ));
                                              tries = 0;
                                              lives = 3;
                                              selectedChar = [];
                                              palabraYPista =
                                                  obtenerPalabraYPistaAleatoria();
                                              context.go('/');
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.purple.shade900,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                textStyle: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            child: const Text(
                                              'Terminar',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          btnOkOnPress: () async {
                                            setState(() {
                                              //reiniciamos el juego
                                              tries = 0;
                                              selectedChar = [];
                                              score++;
                                              palabraYPista =
                                                  obtenerPalabraYPistaAleatoria();
                                            });
                                          },
                                        ).show();
                                      }
                                      AppSounds().goodSound();
                                    }
                                    print('tries $tries');
                                  });
                                },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple.shade900,
                              padding: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          child: Text(
                            character[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ))
              ],
            )));
  }
}
