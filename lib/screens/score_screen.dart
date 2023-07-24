import 'package:flutter/material.dart';
import 'package:hangman/models/score_response.dart';
import 'package:hangman/repository/data_repository.dart';
import 'package:hangman/theme/box_decoration.dart';
import 'package:hangman/widgets/appBar.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> topRanks = ["🥇", "🥈", "🥉"];

    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: Container(
            width: size.width,
            height: size.height,
            decoration: decoration,
            child: Column(
              children: [
                const AppBar_widget(
                  title: 'Mejores Puntajes',
                  rutaGoBack: '/',
                ),
                const SizedBox(
                  height: 20,
                ),

                //hacemos una tabla donde tenga el rank, nombre, fecha y score del juga
                FutureBuilder(
                  future: DataRepository().recuperarScoreResponse(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final scoreResponse = snapshot.data;

                            // Ordenar la lista de Score por score de mayor a menor
                            final scoresOrdenados = scoreResponse.toList()
                              ..sort(SocreResponse.compareByScore);
                            final score = scoresOrdenados[index];

                            return Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (index < topRanks.length)
                                    Text(
                                      topRanks[index],
                                      style: const TextStyle(
                                        fontSize: 24,
                                      ),
                                    )
                                  else
                                    Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  Text(
                                    score.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    score.fecha,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    score.score.toString(),
                                    style: const TextStyle(
                                      color: Colors.purple,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            )));
  }
}
