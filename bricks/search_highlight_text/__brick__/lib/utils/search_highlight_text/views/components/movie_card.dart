import 'package:flutter/material.dart';
import 'package:search_highlight_text/search_highlight_text.dart';

import '../../models/models.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: SearchHighlightText( // <-- Here we use the SearchHighlightText widget to highlight the search text (if any) in the movie title
          movie.word,
        ),
        // subtitle: Text(movie.definition),
        // leading: SizedBox(
        //   width: 100,
        //   child: Image.network(
        //     movie.posterUrl,
        //     fit: BoxFit.cover,
        //     errorBuilder: (context, error, stackTrace) {
        //       return const Icon(Icons.error);
        //     },
        //   ),
        // ),
      ),
    );
  }
}
