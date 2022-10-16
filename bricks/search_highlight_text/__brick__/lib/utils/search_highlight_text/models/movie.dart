import 'dart:convert';

import 'package:equatable/equatable.dart';

class MovieModel with EquatableMixin {
  int id;
  String word;
  String definition;
  // String posterUrl;
  // String plot;
  // String actors;
  // String director;
  

  MovieModel({
    required this.id,
    required this.word,
    required this.definition,
    // required this.posterUrl,
    // required this.plot,
    // required this.actors,
    // required this.director,
  });

  @override
  List<Object?> get props => [
        // id,
      ];
      
      

  Map<String, dynamic> toMap() {
    return {
      MovieModelFields.id: id,
      MovieModelFields.word: word,
      MovieModelFields.definition: definition,
      // MovieModelFields.posterUrl: posterUrl,
      // MovieModelFields.plot: plot,
      // MovieModelFields.actors: actors,
      // MovieModelFields.director: director,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map[MovieModelFields.id],
      word: map[MovieModelFields.word],
      definition: map[MovieModelFields.definition],
      // posterUrl: map[MovieModelFields.posterUrl],
      // plot: map[MovieModelFields.plot],
      // actors: map[MovieModelFields.actors],
      // director: map[MovieModelFields.director],
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) => MovieModel.fromMap(json.decode(source));
}

abstract class MovieModelFields {
  static const id = 'id';
  static const word = 'word';
  static const definition = 'definition';
  // static const posterUrl = 'posterUrl';
  // static const plot = 'plot';
  // static const actors = 'actors';
  // static const director = 'director';
  
}