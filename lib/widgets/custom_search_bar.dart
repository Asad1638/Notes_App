
import 'package:flutter/material.dart';
import 'package:hive_notes/models/notes_model.dart';

class CustomSearchDelegate extends SearchDelegate<NotesModel?> {
  final List<NotesModel> notes;
  final Function(String) onSearch;

  CustomSearchDelegate(this.notes, this.onSearch);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          onSearch(query);
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? []
        : notes
            .where((note) =>
                note.title.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final suggestion = suggestionList[index];
        return ListTile(
          title: Text(suggestion.title),
          onTap: () {
            
            Navigator.of(context).pop(suggestion);
          },
        );
      },
    );
  }
}
