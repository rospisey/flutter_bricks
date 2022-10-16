import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../controllers/search_controller.dart';

class SearchField extends ConsumerStatefulWidget {
  const SearchField({required this.controller, Key? key}) : super(key: key);
  final SearchController controller;

  @override
  ConsumerState<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends ConsumerState<SearchField> {
  late final TextEditingController _textEditingController;
  late final BehaviorSubject<String> _searchOnChange;

  @override
  void initState() {
    _textEditingController =
        TextEditingController(text: widget.controller.searchText);
    _searchOnChange = BehaviorSubject<String>();

    // search after change text is completed (debounce time: 500ms)
    _searchOnChange
        .debounce((_) => TimerStream(true, const Duration(milliseconds: 500)))
        .listen((value) {
      //
      widget.controller.search(value);
    });

    super.initState();
  }

  @override
  dispose() {
    _searchOnChange.close();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = widget.controller;

    // update search field text when user select a suggestion to search
    if (_textEditingController.text != controller.searchText) {
      //
      if (!_searchOnChange.hasValue ||
          _searchOnChange.value.toString().trim().isEmpty) {
        _textEditingController.text = controller.searchText;
        _textEditingController.selection = TextSelection(
          baseOffset: controller.searchText.length,
          extentOffset: controller.searchText.length,
        );
      }
    }
    return SizedBox(
      child: Row(
        children: [
          Expanded(
            child: AnimatedContainer(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              duration: const Duration(milliseconds: 300),
              height: 44,
              child: TextField(
                onTap: () {
                  // this to fix the issue of the Text field cursor position in RTL goes to the penultimate character
                  if (_textEditingController.selection ==
                      TextSelection.fromPosition(TextPosition(
                          offset: _textEditingController.text.length - 1))) {
                    setState(() {
                      _textEditingController.selection =
                          TextSelection.fromPosition(TextPosition(
                              offset: _textEditingController.text.length));
                    });
                  }
                },
                autofocus: false,
                textAlignVertical: TextAlignVertical.center,
                controller: _textEditingController,
                textInputAction: TextInputAction.search,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsetsDirectional.only(
                    start: 16,
                    end: 16,
                    bottom: 8,
                    top: 8,
                  ),
                  fillColor:   Colors.white,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1,
                    ),
                  ),
                  hintText: '',
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  suffixIcon: controller.searchTextIsNotEmpty
                      ? InkWell(
                          onTap: () {
                            controller.clearSearch();
                            _textEditingController.clear();
                          },
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.grey,
                          ),
                        )
                      : null,
                ),
                onChanged: (value) {
                  //
                  _searchOnChange.add(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
