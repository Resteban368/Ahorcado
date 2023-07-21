// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hangman/game/app_sounds.dart';
import 'package:hangman/game/list_letters.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
// Map<String, String> palabraYPista = obtenerPalabraYPistaAleatoria();

  GameBloc()
      : super(GameInitial(palabra: 'ERM', pista: 'medio de transporte')) {
    on<GameStart>((event, emit) {
      try {
        print('evento de comenzar el juego');
      } catch (e, s) {
        print('errror en el bloc $e $s');
      }
    });
    add(GameStart());

    on<GameSelectChar>((event, emit) {
      try {
        print('evento de seleccionar letra ${event.char}');

        final List<String> selectedChar = event.selectedChar;
        //agregamos la letra seleccionada a la lista de letras seleccionadas
        selectedChar.add(event.char);

        if (event.palabra.contains(event.char)) {


          print('letra correcta');
          AppSounds().goodSound();


        } else {

          AppSounds().errorSound();
          final tries = event.tries + 1;

          emit(GameSelectCharState(
              tries: tries,
              palabra: event.palabra,
              pista: event.pista,
              selectedChar: selectedChar));

          if (tries == 6) {
            print('perdiste');
            AppSounds().gameOverSound();
            return;
          }

              

        }

        // emit(GameSelectCharState(selectedChar));
      } catch (e, s) {
        print('errror en el bloc $e $s');
      }
    });
  }
}



// ignore_for_file: avoid_print, deprecated_member_use

// import 'package:animate_do/animate_do.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:date_format/date_format.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hangman/blocs/game_bloc/game_bloc.dart';
// import 'package:hangman/game/app_sounds.dart';
// import 'package:hangman/game/hidden_letter.dart';
// import 'package:hangman/game/list_letters.dart';
// import 'package:hangman/models/score_response.dart';
// import 'package:hangman/repository/data_repository.dart';
// import 'package:hangman/theme/box_decoration.dart';

// class GameScreen extends StatelessWidget {
//   const GameScreen({Key? key, required this.name}) : super(key: key);

//   final String name;

//   @override
//   Widget build(BuildContext context) {
//     // var lives = 3;
//     // var tries = 0;
//     // var score = 0;
//     // List<String> selectedChar = [];
//     var character = 'abcdefghijklmnñopqrstuvwxyz'.toUpperCase();

// //meotod para comprobar si el usuario tiene vidas para seguir jugando
//     bool usuarioGano(List<String> letrasUsadas, String palabraParaAdivinar) {
//       // Convertimos la palabra para adivinar en una lista de letras
//       List<String> letrasPalabra = palabraParaAdivinar.split('');

//       // Comprobamos si todas las letras de la palabra están en las letras usadas
//       bool todasLasLetrasAdivinadas =
//           letrasPalabra.every((letra) => letrasUsadas.contains(letra));

//       return todasLasLetrasAdivinadas;
//     }

//     final size = MediaQuery.sizeOf(context);

//     final myBloc = BlocProvider.of<GameBloc>(context);

//     return Scaffold(
//         body: BlocBuilder<GameBloc, GameState>(
//       bloc: myBloc,
//       builder: (context, state) {
//         return Container(
//             width: size.width,
//             height: size.height,
//             decoration: decoration,
//             child: Column(
//               children: [
//                 SizedBox(
//                     width: size.width,
//                     height: size.height * 0.6,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           margin: const EdgeInsets.all(10),
//                           width: size.width,
//                           height: size.height * 0.1,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Stack(
//                                 children: <Widget>[
//                                   const Icon(
//                                     Icons.favorite,
//                                     color: Colors.red,
//                                     size: 45,
//                                   ),
//                                   Positioned(
//                                     left: 18,
//                                     top: 11,
//                                     child: Text(
//                                       state.live.toString(),
//                                       style: GoogleFonts.outfit(
//                                           fontSize: 17,
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Text(
//                                 'Puntaje: ${state.score}',
//                                 style: GoogleFonts.outfit(
//                                     fontSize: 23,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),

//                               //icono de bombilla

//                               IconButton(
//                                   onPressed: () {
//                                     AppSounds().helpSound();
//                                     print(state.pista);
//                                     AwesomeDialog(
//                                       dismissOnTouchOutside: false,
//                                       context: context,
//                                       animType: AnimType.BOTTOMSLIDE,
//                                       title: 'Pista',
//                                       desc: state.pista,
//                                       btnOkOnPress: () async {
//                                         //cerramos el dialogo
//                                       },
//                                     ).show();
//                                   },
//                                   icon: const Icon(
//                                     Icons.lightbulb,
//                                     color: Colors.amber,
//                                     size: 40,
//                                   )),

//                               //iconod de home
//                             ],
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Image.asset(
//                           'assets/${state.tries}.png',
//                           fit: BoxFit.cover,
//                           width: 200,
//                           height: 200,
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         SizedBox(
//                             width: size.width,
//                             // height: size.height * 0.14,
//                             child: BounceInDown(
//                               duration: const Duration(seconds: 1),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: state.palabra
//                                     .split("")
//                                     .map((e) => HiddenLetter(
//                                           e,
//                                           !state.selectedChar.contains(e),
//                                         ))
//                                     .toList(),
//                               ),
//                             ))
//                       ],
//                     )),
//                 Expanded(
//                     child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: GridView.count(
//                     physics: const NeverScrollableScrollPhysics(),
//                     crossAxisCount: 7,
//                     children: List.generate(character.length, (index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(5),
//                         child: ElevatedButton(
//                           onPressed: () {
                            
//                             myBloc.add(GameSelectChar(
//                                 character[index].toString(),
//                                 state.selectedChar,
//                                 state.palabra,
//                                 state.tries,
//                                 state.pista));
//                           },
//                           // onPressed: state.selectedChar
//                           //         .contains(character[index].toUpperCase())
//                           //     ? null
//                           //     : () {
//                           //         state.selectedChar
//                           //             .add(character[index].toUpperCase());
//                           //         print(state.selectedChar);

//                           //         if (!palabraYPista['palabra']!
//                           //             .split("")
//                           //             .contains(
//                           //                 character[index].toUpperCase())) {
//                           //           print('no contiene');

//                           //           AppSounds().errorSound();

//                           //           // tries++;
//                           //           if (state.tries == 6) {
//                           //             // lives--;

//                           //             if (state.live == 0) {
//                           //               AppSounds().errorSound();

//                           //               AwesomeDialog(
//                           //                 dismissOnTouchOutside: false,
//                           //                 context: context,
//                           //                 dialogType: DialogType.ERROR,
//                           //                 animType: AnimType.BOTTOMSLIDE,
//                           //                 title: 'HAS PERDIDO TODAS TUS VIDAS',
//                           //                 btnOkOnPress: () {
//                           //                   //guardamos el puntaje

//                           //                   DataRepository()
//                           //                       .guardarScoreResponse(
//                           //                           SocreResponse(
//                           //                     name: name,
//                           //                     score: state.score,
//                           //                     fecha:
//                           //                         //la fecha actual pero sin la hora solo la fecha
//                           //                         formatDate(DateTime.now(),
//                           //                             [dd, '/', mm, '/', yyyy]),
//                           //                   ));

//                           //                   // tries = 0;
//                           //                   // score = 0;
//                           //                   // lives = 3;
//                           //                   // selectedChar = [];
//                           //                   palabraYPista =
//                           //                       obtenerPalabraYPistaAleatoria();
//                           //                   context.go('/');
//                           //                 },
//                           //               ).show();
//                           //               return;
//                           //             } else {
//                           //               AppSounds().gameOverSound();

//                           //               AwesomeDialog(
//                           //                 dismissOnTouchOutside: false,
//                           //                 context: context,
//                           //                 dialogType: DialogType.ERROR,
//                           //                 animType: AnimType.BOTTOMSLIDE,
//                           //                 title: 'PERDISTE',
//                           //                 desc:
//                           //                     'La palabra era: ${palabraYPista['palabra']}',
//                           //                 btnOkOnPress: () async {
//                           //                   // setState(() {
//                           //                   //reiniciamos el juego
//                           //                   // tries = 0;
//                           //                   // selectedChar = [];
//                           //                   palabraYPista =
//                           //                       obtenerPalabraYPistaAleatoria();
//                           //                   // });
//                           //                 },
//                           //               ).show();
//                           //               return;
//                           //             }
//                           //           }
//                           //         } else {
//                           //           if (usuarioGano(state.selectedChar,
//                           //               palabraYPista['palabra']!)) {
//                           //             AppSounds().successSound();
//                           //             AwesomeDialog(
//                           //               dismissOnTouchOutside: false,
//                           //               context: context,
//                           //               dialogType: DialogType.SUCCES,
//                           //               animType: AnimType.BOTTOMSLIDE,
//                           //               title: 'GANASTE',
//                           //               btnCancel: ElevatedButton(
//                           //                 onPressed: () {
//                           //                   // setState(() {
//                           //                   // score++;
//                           //                   // });

//                           //                   DataRepository()
//                           //                       .guardarScoreResponse(
//                           //                           SocreResponse(
//                           //                     name: name,
//                           //                     score: state.score,
//                           //                     fecha:
//                           //                         //la fecha actual pero sin la hora solo la fecha
//                           //                         formatDate(DateTime.now(),
//                           //                             [dd, '/', mm, '/', yyyy]),
//                           //                   ));
//                           //                   // tries = 0;
//                           //                   // lives = 3;
//                           //                   // selectedChar = [];
//                           //                   palabraYPista =
//                           //                       obtenerPalabraYPistaAleatoria();
//                           //                   context.go('/');
//                           //                 },
//                           //                 style: ElevatedButton.styleFrom(
//                           //                     backgroundColor:
//                           //                         Colors.purple.shade900,
//                           //                     padding: const EdgeInsets.all(10),
//                           //                     shape: RoundedRectangleBorder(
//                           //                         borderRadius:
//                           //                             BorderRadius.circular(
//                           //                                 20)),
//                           //                     textStyle: const TextStyle(
//                           //                         fontSize: 15,
//                           //                         fontWeight: FontWeight.bold)),
//                           //                 child: const Text(
//                           //                   'Terminar',
//                           //                   style: TextStyle(
//                           //                     color: Colors.white,
//                           //                     fontWeight: FontWeight.bold,
//                           //                   ),
//                           //                 ),
//                           //               ),
//                           //               btnOkOnPress: () async {
//                           //                 // setState(() {
//                           //                 //reiniciamos el juego
//                           //                 // tries = 0;
//                           //                 // selectedChar = [];
//                           //                 // score++;
//                           //                 palabraYPista =
//                           //                     obtenerPalabraYPistaAleatoria();
//                           //                 // });
//                           //               },
//                           //             ).show();
//                           //           }
//                           //           AppSounds().goodSound();
//                           //         }
//                           //         // print('tries $tries');
//                           //       },

//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.purple.shade900,
//                               padding: const EdgeInsets.all(10),
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20)),
//                               textStyle: const TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.bold)),
//                           child: Text(
//                             character[index],
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                 ))
//               ],
//             ));
//       },
//     ));
//   }
// }
