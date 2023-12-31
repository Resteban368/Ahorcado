// ignore_for_file: avoid_print, deprecated_member_use, non_constant_identifier_names

import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hangman/blocs/game_bloc/game_bloc.dart';
import 'package:hangman/game/app_sounds.dart';
import 'package:hangman/game/hidden_letter.dart';
import 'package:hangman/theme/box_decoration.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    String qwertyOrder = 'QWERTYUIOPASDFGHJKLÑZXCVBNM';





//meotod para comprobar si el usuario tiene vidas para seguir jugando

    final size = MediaQuery.sizeOf(context);

    final myBloc = BlocProvider.of<GameBloc>(context);

    return Scaffold(
        body: BlocBuilder<GameBloc, GameState>(
      bloc: myBloc,
      builder: (context, state) {
        print('state $state');

        if (state is GameEndState) {
          print('termino el juego');
          return _EndGameContainer( name: name, score: state.score,);
        }

        if (state is StartGame || state is GameSelectCharState) {
          print('inicia el juego');

          return Container(
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
                                        state.live.toString(),
                                        style: GoogleFonts.outfit(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Puntaje: ${state.score}',
                                  style: GoogleFonts.outfit(
                                      fontSize: 23,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),

                                //icono de bombilla

                                IconButton(
                                    onPressed: () {
                                      AppSounds().helpSound();
                                      print(state.pista);
                                      AwesomeDialog(
                                        dismissOnTouchOutside: false,
                                        context: context,
                                        animType: AnimType.BOTTOMSLIDE,
                                        title: 'Pista',
                                        desc: state.pista,
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
                            'assets/${state.tries}.png',
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
                                  children: state.palabra
                                      .split("")
                                      .map((e) => HiddenLetter(
                                            e,
                                            !state.selectedChar.contains(e),
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
                      
                      children: List.generate(qwertyOrder.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: ElevatedButton(
                            onPressed: state.selectedChar
                                    .contains(qwertyOrder[index].toUpperCase())
                                ? null
                                : () {
                                    myBloc.add(
                                      GameSelectCharEvent(
                                        namePlayer: name,
                                        char: qwertyOrder[index].toUpperCase(),
                                        palabra: state.palabra,
                                        pista: state.pista,
                                        tries: state.tries,
                                        selectedChar: state.selectedChar,
                                        score: state.score,
                                        live: state.live,
                                      ),
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple.shade900,
                                padding: const EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            child: Text(
                              qwertyOrder[index],
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
              ));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));


  }

     //         state.selectedChar
                            //             .add(character[index].toUpperCase());
                            //         print(state.selectedChar);

                            //         if (!palabraYPista['palabra']!
                            //             .split("")
                            //             .contains(
                            //                 character[index].toUpperCase())) {
                            //           print('no contiene');

                            //           AppSounds().errorSound();

                            //           // tries++;
                            //           if (state.tries == 6) {
                            //             // lives--;

                            //             if (state.live == 0) {
                            //               AppSounds().errorSound();

                            //               AwesomeDialog(
                            //                 dismissOnTouchOutside: false,
                            //                 context: context,
                            //                 dialogType: DialogType.ERROR,
                            //                 animType: AnimType.BOTTOMSLIDE,
                            //                 title: 'HAS PERDIDO TODAS TUS VIDAS',
                            //                 btnOkOnPress: () {
                            //                   //guardamos el puntaje

                            //                   DataRepository()
                            //                       .guardarScoreResponse(
                            //                           SocreResponse(
                            //                     name: name,
                            //                     score: state.score,
                            //                     fecha:
                            //                         //la fecha actual pero sin la hora solo la fecha
                            //                         formatDate(DateTime.now(),
                            //                             [dd, '/', mm, '/', yyyy]),
                            //                   ));

                            //                   // tries = 0;
                            //                   // score = 0;
                            //                   // lives = 3;
                            //                   // selectedChar = [];
                            //                   palabraYPista =
                            //                       obtenerPalabraYPistaAleatoria();
                            //                   context.go('/');
                            //                 },
                            //               ).show();
                            //               return;
                            //             } else {
                            //               AppSounds().gameOverSound();

                            //               AwesomeDialog(
                            //                 dismissOnTouchOutside: false,
                            //                 context: context,
                            //                 dialogType: DialogType.ERROR,
                            //                 animType: AnimType.BOTTOMSLIDE,
                            //                 title: 'PERDISTE',
                            //                 desc:
                            //                     'La palabra era: ${palabraYPista['palabra']}',
                            //                 btnOkOnPress: () async {
                            //                   // setState(() {
                            //                   //reiniciamos el juego
                            //                   // tries = 0;
                            //                   // selectedChar = [];
                            //                   palabraYPista =
                            //                       obtenerPalabraYPistaAleatoria();
                            //                   // });
                            //                 },
                            //               ).show();
                            //               return;
                            //             }
                            //           }
                            //         } else {
                            //           if (usuarioGano(state.selectedChar,
                            //               palabraYPista['palabra']!)) {
                            //             AppSounds().successSound();
                            // AlertDialog(context, state).show();
                            //           }
                            //           AppSounds().goodSound();
                            //         }
                            //         // print('tries $tries');
                            //       },
}

class _EndGameContainer extends StatelessWidget {
  const _EndGameContainer({
    required this.name,
    required this.score,
  });

  final String name;
  final int score;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      height: size.height,
      decoration: decoration,
      child: AlertDialog(
        backgroundColor: Colors.purple.shade900,
        title: Text(
          'Juego terminado',
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
              fontSize: 23,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: size.width,
          height: size.height * 0.45,
          // color: Colors.red,
          child: Column(
            children: [
              Image.asset(
                'assets/gallow.png',
                fit: BoxFit.cover,
                width: 300,
                height: 300,
              ),
              Text(
                '$name \nTu puntaje es: $score',
                style: GoogleFonts.outfit(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 57,
                    ),
                  ),
                onPressed: () {
                  context.go('/');
                },
                child:  Text('Terminar', style: GoogleFonts.outfit(
                        fontSize: 25, fontWeight: FontWeight.bold, color: Colors.purple))),
          )
        ],
      ),
    );
  }
}
