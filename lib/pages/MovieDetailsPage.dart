import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_modulo_4/widgets/MovieGenres_model.dart';
import '../model/Movie_model.dart';
import 'package:http/http.dart' as http;

class MovieDetailsPage extends StatefulWidget {
  final MovieModel? movie;

  const MovieDetailsPage({Key? key, this.movie}) : super(key: key);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  List<MovieGenreModel> genres = [];
  final String apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZTY2ZjkyOWI1ZTJjMGNjMjhiMTdjMGI3NDFkMDQ1OSIsInN1YiI6IjY2NGFiZmQ0NjU4YmViMmIwNjk2MjI2MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KTfaE78Lmqqh-iqVRaYOpvYufyIRvin7LhlHVRlht8s';

  @override
  void initState() {
    super.initState();
    fetchGenres();
  }

  Future<void> fetchGenres() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/genre/movie/list'),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['genres'];

      setState(() {
        genres = results
            .map((genreJson) => MovieGenreModel.fromJson(genreJson))
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
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          NetworkImage('${widget.movie?.backdropPath ?? ''}'),
                      fit: BoxFit.cover,
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
                '${widget.movie?.title ?? ''}',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 164, 112)),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
              child: Text(
                '${DateTime.parse(widget.movie!.releaseDate!).year} - ${widget.movie?.voteAverage!.toStringAsFixed(1) ?? ''}',
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
                children: widget.movie?.genreIds
                        ?.map((id) => _chipTag(_getGenreNameById(id)))
                        .toList() ??
                    [],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 50, top: 0, bottom: 100, right: 50),
              child: Text(
                '${widget.movie?.overview}',
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
        orElse: () => MovieGenreModel(id: 0, name: 'Unknown'));
    return genre.name;
  }

  Chip _chipTag(String nameTag) {
    return Chip(
      label: Text(nameTag, style: TextStyle(color: Colors.white)),
      backgroundColor: Color.fromARGB(255, 43, 43, 56),
    );
  }
}
