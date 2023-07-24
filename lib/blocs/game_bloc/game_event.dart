part of 'game_bloc.dart';

sealed class GameEvent extends Equatable {
  final String palabra;
  final String pista;
  final int tries;
  final List<String> selectedChar;
  final int score;
  final int live;

  const GameEvent({
    required this.palabra,
    required this.pista,
    required this.tries,
    required this.selectedChar,
    required this.score,
    required this.live,
  });

  @override
  List<Object> get props => [];
}



class GameStartEvent extends GameEvent {
  const GameStartEvent({
    required super.palabra,
    required super.pista,
    required super.tries,
    required super.selectedChar,
    required super.score,
    required super.live,
  });
}

//evento de seleccionar una letra
class GameSelectCharEvent extends GameEvent {
  final String char;
  final String namePlayer;
  const GameSelectCharEvent({
    required this.namePlayer,
    required this.char,
    required super.palabra,
    required super.pista,
    required super.tries,
    required super.selectedChar,
    required super.score,
    required super.live,
  });

  @override
  List<Object> get props => [
        char,

  ];
}

//evento de terminar el juego
class GameEndEvent extends GameEvent {
  final String namePlayer;

  const GameEndEvent({
    required this.namePlayer,
    required super.palabra,
    required super.pista,
    required super.tries,
    required super.selectedChar,
    required super.score,
    required super.live,
  });

  @override
  List<Object> get props => [
        namePlayer,
      ];
}


