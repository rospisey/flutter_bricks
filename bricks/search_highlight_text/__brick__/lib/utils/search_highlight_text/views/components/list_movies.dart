import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/movie.dart';
import 'movie_card.dart';

class ListMoviesWidget extends ConsumerWidget {
  const ListMoviesWidget({required this.listMovies, Key? key})
      : super(key: key);

  final List<MovieModel> listMovies;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    if (listMovies.isEmpty) {
      return const Center(
        child: Text('No movies found'),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: listMovies.length,
      itemBuilder: (context, index) {
        return MovieCard(
          movie: listMovies[index],
        );
      },
    );
  }
}
