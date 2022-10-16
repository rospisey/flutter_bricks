import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_highlight_text/search_highlight_text.dart';

import '../controllers/search_controller.dart';
import 'components/components.dart';

class SearchView extends ConsumerWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controller = ref.watch(searchController);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('Search Movies Example'),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SearchField(
              controller: controller,
            ),
            Expanded(
              child: controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SearchTextInheritedWidget(
                      searchText: controller
                          .searchText, // <-- Here we pass the search text to the widget tree to be used by the SearchHighlightText widget
                      child: ListMoviesWidget(
                        listMovies: controller.movies,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
