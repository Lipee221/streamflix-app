import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_modulo_4/model/Movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MovieEvent {}

class FetchMoviesEvent extends MovieEvent {}

class ToggleFavoriteEvent extends MovieEvent {
  final MovieModel movie;

  ToggleFavoriteEvent(this.movie);
}

abstract class MovieState {}

class MoviesLoadedState extends MovieState {
  final List<MovieModel> movies;
  final Set<int> favoriteMovieIds;

  MoviesLoadedState(this.movies, this.favoriteMovieIds);
}

class MovieErrorState extends MovieState {
  final String errorMessage;

  MovieErrorState(this.errorMessage);
}

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final String apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZTY2ZjkyOWI1ZTJjMGNjMjhiMTdjMGI3NDFkMDQ1OSIsInN1YiI6IjY2NGFiZmQ0NjU4YmViMmIwNjk2MjI2MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KTfaE78Lmqqh-iqVRaYOpvYufyIRvin7LhlHVRlht8s';

  MovieBloc() : super(MoviesLoadedState([], {})) {
    on<FetchMoviesEvent>(_mapFetchMoviesEventToState);
    on<ToggleFavoriteEvent>(_mapToggleFavoriteEventToState);
    _loadFavoriteIds();
  }

  Future<void> fetchMovies() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/now_playing'),
        headers: {
          'Authorization': 'Bearer $apiKey',
        },
      );

      if (response.statusCode == 200) {
        final moviesData = json.decode(response.body);
        final List<MovieModel> movies = (moviesData['results'] as List)
            .map((movieJson) => MovieModel.fromJson(movieJson))
            .toList();
        emit(MoviesLoadedState(movies, state is MoviesLoadedState ? (state as MoviesLoadedState).favoriteMovieIds : {}));
      } else {
        throw Exception('Erro ao carregar Filmes');
      }
    } catch (e) {
      emit(MovieErrorState('Erro ao carregar Filmes: $e'));
    }
  }

  Future<void> _mapFetchMoviesEventToState(
    FetchMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    await fetchMovies();
  }

  Future<void> _mapToggleFavoriteEventToState(
    ToggleFavoriteEvent event,
    Emitter<MovieState> emit,
  ) async {
    if (state is MoviesLoadedState) {
      final currentState = state as MoviesLoadedState;
      final Set<int> updatedFavorites = Set.from(currentState.favoriteMovieIds);
      if (event.movie.id != null) {
        if (updatedFavorites.contains(event.movie.id)) {
          updatedFavorites.remove(event.movie.id);
        } else {
          updatedFavorites.add(event.movie.id!);
        }
        await _saveFavoriteIds(updatedFavorites);
        emit(MoviesLoadedState(currentState.movies, updatedFavorites));
      }
    }
  }

  Future<void> _loadFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favoriteMovieIds')?.map((id) => int.parse(id)).toSet() ?? {};
    if (state is MoviesLoadedState) {
      emit(MoviesLoadedState((state as MoviesLoadedState).movies, favoriteIds));
    }
  }

  Future<void> _saveFavoriteIds(Set<int> favoriteIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteMovieIds', favoriteIds.map((id) => id.toString()).toList());
  }
}
