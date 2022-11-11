import 'dart:convert';

import 'package:equatable/equatable.dart';

class MovieModel with EquatableMixin {
  int id;
  String title;
  String year;
  String posterUrl;
  String plot;
  String actors;
  String director;
  

  MovieModel({
    required this.id,
    required this.title,
    required this.year,
    required this.posterUrl,
    required this.plot,
    required this.actors,
    required this.director,
  });

  @override
  List<Object?> get props => [
        id,
      ];
      
      

  Map<String, dynamic> toMap() {
    return {
      MovieModelFields.id: id,
      MovieModelFields.title: title,
      MovieModelFields.year: year,
      MovieModelFields.posterUrl: posterUrl,
      MovieModelFields.plot: plot,
      MovieModelFields.actors: actors,
      MovieModelFields.director: director,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map[MovieModelFields.id],
      title: map[MovieModelFields.title],
      year: map[MovieModelFields.year],
      posterUrl: map[MovieModelFields.posterUrl],
      plot: map[MovieModelFields.plot],
      actors: map[MovieModelFields.actors],
      director: map[MovieModelFields.director],
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) => MovieModel.fromMap(json.decode(source));
}

abstract class MovieModelFields {
  static const id = 'id';
  static const title = 'title';
  static const year = 'year';
  static const posterUrl = 'posterUrl';
  static const plot = 'plot';
  static const actors = 'actors';
  static const director = 'director';
  
}