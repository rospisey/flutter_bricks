import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/movie.dart';
import '../repositories/movies_repo_controller.dart';

final searchController =
    ChangeNotifierProvider.autoDispose<SearchController>((ref) {
  return SearchController(ref.read);
});

class SearchController extends ChangeNotifier {
  final Reader read;
  late final MoviesRepoController _repoController;

  List<MovieModel> _movies = [];

  String _searchText = '';

  SearchController(this.read) {
    _repoController = MoviesRepoController();
    _init();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future _init() async {
    isLoading = true;
    await searchMovies();
    isLoading = false;
  }

  Future searchMovies() async {
    // search movies
    final movies = await _repoController.searchMovies(_searchText);
    // update movies list
    _movies = movies;
    notifyListeners();
  }

  List<MovieModel> get movies => _movies;

  Future refresh() async {
    isLoading = true;
    await searchMovies();
    isLoading = false;
  }

  bool get searchTextIsEmpty => _searchText.trim().isEmpty;

  bool get searchTextIsNotEmpty => _searchText.trim().isNotEmpty;

  String get searchText => _searchText;

  void search(String value) async {
    if (value.trim() == _searchText) {
      return;
    }

    _searchText = value;

    refresh();
  }

  void clearSearch() {
    if (searchTextIsEmpty) {
      notifyListeners();
      return;
    }
    search('');
  }

  void showSearchField() {
    notifyListeners();
  }
}
