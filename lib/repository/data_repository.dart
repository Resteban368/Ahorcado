// ignore_for_file: unused_element, avoid_print

import 'dart:convert';

import 'package:hangman/models/score_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataRepository {
  factory DataRepository() {
    return _singleton;
  }

  DataRepository._();

  static final DataRepository _singleton = DataRepository._();



void guardarScoreResponse(SocreResponse scoreResponse) async {
    final prefs = await SharedPreferences.getInstance();

    //llamamos la lista que tenemos guardada
    final scores = await recuperarScoreResponse();


print('ScoreResponse recuperado de SharedPreferences $scores');


print('ScoreResponse  $scoreResponse');

    //agregamos el nuevo score
    scores.add(scoreResponse);

    print('ScoreResponse agregado a la lista $scores');

    //guardamos esa lista
    final jsonScores = scores.map((score) => score.toMap()).toList();
    print('ScoreResponse convertido a json $jsonScores');
    prefs.setString('scoreResponse', json.encode(jsonScores));
    print('ScoreResponse guardado en SharedPreferences');




    // final jsonScoreResponse = scoreResponse.toMap();
    // prefs.setString('scoreResponse', json.encode(jsonScoreResponse));
    // print('ScoreResponse guardado en SharedPreferences');
  }
  



  Future<List<SocreResponse>> recuperarScoreResponse() async {
    print('Recuperando ScoreResponse de SharedPreferences');
    final prefs = await SharedPreferences.getInstance();
    final encodedScores = prefs.getString('scoreResponse');
    if (encodedScores != null) {

      final jsonScores = json.decode(encodedScores) as List<dynamic>;
      final response =jsonScores.map((jsonScore) => SocreResponse.fromMap(jsonScore)).toList();
      print('ScoreRespons $response');
      return response;
    } else {
      return [];
    }
  }

 



}
