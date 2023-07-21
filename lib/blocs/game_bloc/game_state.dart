part of 'game_bloc.dart';

sealed class GameState {
  GameState({required this.palabra, required this.pista});
  final int live = 3; //vidas
  final int tries = 0; //intentos
  final int score = 0; //puntaje
  final List<String> selectedChar = [];
  final String palabra;
  final String pista;
}

class GameInitial extends GameState {
  GameInitial({required super.palabra, required super.pista});
}

//estado para cuando agrego una letra a la lista de letras seleccionadas
class GameSelectCharState extends GameState {
  final List<String> selectedChar;
  final int tries;

  GameSelectCharState({
      required this.tries, 
      required super.palabra,
      required super.pista,
      required this.selectedChar});
}
