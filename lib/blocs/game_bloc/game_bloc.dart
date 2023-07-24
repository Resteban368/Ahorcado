// ignore_for_file: avoid_print, prefer_const_literals_to_create_immutables
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hangman/game/app_sounds.dart';
import 'package:hangman/game/list_letters.dart';
part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc()
      : super(GameInitial(
          palabra: '',
          pista: '',
          score: 0,
          tries: 0,
          selectedChar: [],
          live: 3,
        )) {
    on<GameStartEvent>((event, emit) {
      emit(StartGame(
          palabra: event.palabra,
          pista: event.pista,
          score: event.score,
          tries: event.tries,
          selectedChar: event.selectedChar,
          live: event.live));
    });
    Map<String, String> palabraYPista = obtenerPalabraYPistaAleatoria();
    add(GameStartEvent(
      palabra: palabraYPista['palabra']!,
      pista: palabraYPista['pista']!,
      score: 0,
      tries: 0,
      selectedChar: [],
      live: 3,
    ));

    on<GameSelectCharEvent>((event, emit) {
      try {
        final List<String> selectedChar = event.selectedChar;
        selectedChar.add(event.char);

        if (event.palabra.contains(event.char)) {
          print('letra correcta');
          AppSounds().goodSound();

          emit(GameSelectCharState(
            tries: event.tries,
            palabra: event.palabra,
            pista: event.pista,
            selectedChar: selectedChar,
            score: event.score,
            live: event.live,
          ));
        } else {
          print('letra incorrecta');
          AppSounds().errorSound();
          final tries = event.tries + 1;

          emit(GameSelectCharState(
              tries: tries,
              palabra: event.palabra,
              pista: event.pista,
              selectedChar: selectedChar,
              score: event.score,
              live: event.live));

          if (usuarioPerdio(event.tries)) {
            print('perdiste vuelve a intentarlo');
            AppSounds().gameOverSound();
            Map<String, String> palabraYPista = obtenerPalabraYPistaAleatoria();
            add(GameStartEvent(
              palabra: palabraYPista['palabra']!,
              pista: palabraYPista['pista']!,
              score: event.score,
              tries: 0,
              selectedChar: [],
              live: event.live - 1,
            ));

            if (event.live == 2) {
              //se termina el juego
              AppSounds().gameOverSound();
              print('Se terminaron las vidas');

            

              add(
                GameEndEvent(
                  namePlayer: event.namePlayer,
                  tries: event.tries,
                  palabra: event.palabra,
                  pista: event.pista,
                  selectedChar: event.selectedChar,
                  score: event.score,
                  live: event.live,
                ),
              );
            }
          }
        }

        final isWin = usuarioGano(event.selectedChar, event.palabra);
        if (isWin) {
          AppSounds().successSound();
          print('Ganaste');

          Map<String, String> palabraYPista = obtenerPalabraYPistaAleatoria();
          add(GameStartEvent(
            palabra: palabraYPista['palabra']!,
            pista: palabraYPista['pista']!,
            score: event.score + 1,
            tries: 0,
            selectedChar: [],
            live: event.live,
          ));
        }
      } catch (e, s) {
        print('errror en el bloc $e $s');
      }
    });

    on<GameEndEvent>((event, emit) {
      emit(GameEndState(
        namePlayer: event.namePlayer,
        tries: event.tries,
        palabra: event.palabra,
        pista: event.pista,
        selectedChar: event.selectedChar,
        score: event.score,
        live: event.live,
      ));
    });
  }
}

bool usuarioGano(List<String> letrasUsadas, String palabraParaAdivinar) {
  List<String> letrasPalabra = palabraParaAdivinar.split('');
  bool todasLasLetrasAdivinadas =
      letrasPalabra.every((letra) => letrasUsadas.contains(letra));
  return todasLasLetrasAdivinadas;
}

bool usuarioPerdio(int tries) {
  if (tries == 5) {
    return true;
  } else {
    return false;
  }
}
