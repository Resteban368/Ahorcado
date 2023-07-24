// ignore_for_file: annotate_overrides, overridden_fields

part of 'game_bloc.dart';

sealed class GameState {
  final String palabra;
  final String pista;
  final int tries;
  final List<String> selectedChar;
  final int score;
  final int live;

  GameState({
    required this.palabra,
    required this.pista,
    required this.tries,
    required this.selectedChar,
    required this.score,
    required this.live,
  });
}

//estado cuando comienza el juego
class StartGame extends GameState {
  StartGame({
    required super.palabra,
    required super.pista,
    required super.tries,
    required super.selectedChar,
    required super.score,
    required super.live,
  });
}

//estado cuando Inicia el juego
class GameInitial extends GameState {
  GameInitial(
      {required super.palabra,
      required super.pista,
      required super.tries,
      required super.selectedChar,
      required super.score,
      required super.live});
}



//estado para selecciono una letra
class GameSelectCharState extends GameState {
  GameSelectCharState(
      {required super.palabra,
      required super.pista,
      required super.tries,
      required super.selectedChar,
      required super.score,
      required super.live});
}

//estadi para cuando termina el juego
class GameEndState extends GameState {
  final String namePlayer;

  GameEndState({
    required this.namePlayer,
    required super.palabra,
    required super.pista,
    required super.tries,
    required super.selectedChar,
    required super.score,
    required super.live,
  });
}
