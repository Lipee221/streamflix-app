import 'package:flutter/material.dart';
import 'package:projeto_modulo_4/pages/MovieDetailsPage.dart';
import 'package:projeto_modulo_4/widgets/Movie_model.dart';

class UpcomingWidget extends StatelessWidget {
  final List<MovieModel> movies;

  UpcomingWidget({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                "Próximas estreias",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: movies.map((movie) => MovieItem(movie: movie)).toList(),
            ))
      ],
    );
  }
}

class MovieItem extends StatelessWidget {
  final MovieModel movie;

  const MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsPage(movie: movie),
          ),
        );
      },
      child: Container(
          child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              movie.backdropPath!,
              height: 180,
              width: 300,
              fit: BoxFit.cover,
            )),
      )),
    );
  }
}
