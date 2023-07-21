// To parse this JSON data, do
//
//     final socreResponse = socreResponseFromMap(jsonString);

import 'dart:convert';

class SocreResponse {
    String? name;
    String? fecha;
    int? score;

    SocreResponse({
        this.name,
        this.fecha,
        this.score,
    });

    factory SocreResponse.fromJson(String str) => SocreResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SocreResponse.fromMap(Map<String, dynamic> json) => SocreResponse(
        name: json["name"],
        fecha: json["fecha"],
        score: json["score"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "fecha": fecha,
        "score": score,
    };



    // Agrega el método de comparación para ordenar por score
  static int compareByScore(SocreResponse a, SocreResponse b) {
    return b.score!.compareTo(a.score as int);
  }
}
