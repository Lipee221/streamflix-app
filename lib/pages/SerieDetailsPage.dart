import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_modulo_4/model/SerieGenres_model.dart';
import '../model/Serie_model.dart';
import 'package:http/http.dart' as http;

class SerieDetailsPage extends StatefulWidget {
  final SerieModel? serie;

  const SerieDetailsPage({Key? key, this.serie}) : super(key: key);

  @override
  _SerieDetailsPageState createState() => _SerieDetailsPageState();
}

class _SerieDetailsPageState extends State<SerieDetailsPage> {
  List<SerieGenreModel> genres = [];
  final String apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZTY2ZjkyOWI1ZTJjMGNjMjhiMTdjMGI3NDFkMDQ1OSIsInN1YiI6IjY2NGFiZmQ0NjU4YmViMmIwNjk2MjI2MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KTfaE78Lmqqh-iqVRaYOpvYufyIRvin7LhlHVRlht8s';

  @override
  void initState() {
    super.initState();
    fetchGenres();
  }

  Future<void> fetchGenres() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/genre/tv/list'),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['genres'];

      setState(() {
        genres = results
            .map((genreJson) => SerieGenreModel.fromJson(genreJson))
            .toList();
      });
    } else {
      throw Exception('Failed to load genres');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF0F111D),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 400, // Altura da imagem do filme
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          NetworkImage('${widget.serie?.backdropPath ?? ''}'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 164, 112),
                      borderRadius: BorderRadius.circular(50)),
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: Color.fromARGB(255, 0, 164, 112),
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 0, 164, 112),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                            ),
                            child: Text(
                              "Assistir",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 0, 164, 112),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                            ),
                            child: Text(
                              "Trailer",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
              child: Text(
                '${widget.serie?.name ?? ''}',
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 164, 112)),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
              child: Text(
                '${DateTime.parse(widget.serie!.firstAirDate!).year} - ${widget.serie?.voteAverage ?? ''}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: widget.serie?.genreIds
                        ?.map((id) => _chipTag(_getGenreNameById(id)))
                        .toList() ??
                    [],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 50, top: 0, bottom: 100, right: 50),
              child: Text(
                '${widget.serie?.overview}',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getGenreNameById(int id) {
    final genre = genres.firstWhere((genre) => genre.id == id,
        orElse: () => SerieGenreModel(id: 0, name: 'Unknown'));
    return genre.name;
  }

  Chip _chipTag(String nameTag) {
    return Chip(
      label: Text(nameTag, style: TextStyle(color: Colors.white)),
      backgroundColor: Color.fromARGB(255, 43, 43, 56),
    );
  }
}
