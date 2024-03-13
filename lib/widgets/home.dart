import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../models/notes_model.dart';
import 'add_notes.dart';
import 'custom_search_bar.dart';
import 'edit_note.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final myBox = Hive.box('Notes');
  late List<NotesModel> notes;
  late List<NotesModel> filteredNotes;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() {
    notes = myBox.values.toList().cast<NotesModel>();
    filteredNotes = notes;
  }

  void editNote(context, NotesModel notesModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNotes(
          notes: notesModel,
        ),
      ),
    ).then((_) {
     
      setState(() {
        _loadNotes();
      });
    });
  }

  void deleteNote(NotesModel notesModel) async {
    await notesModel.delete();
    
    setState(() {
      _loadNotes();
    });
  }

  void _addNote() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNotes();
    })).then((_) {
      // After adding a new note, refresh the UI
      setState(() {
        _loadNotes();
      });
    });
  }

  void _searchNotes(String query) {
    setState(() {
      filteredNotes = notes
          .where((note) =>
              note.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _handleSearchResult(dynamic result) {
    if (result != null && result is NotesModel) {
      // Navigate to details/edit page with the selected note
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditNotes(notes: result),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'N O T E S',
          style: TextStyle(fontSize: 25),
        ),
        titleSpacing: 30,
        // centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final result = await showSearch(
                context: context,
                delegate: CustomSearchDelegate(notes, _searchNotes),
              );

              _handleSearchResult(result);
            },
            icon: const Icon(Icons.search, size: 35),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 20,
                );
              },
              itemCount: filteredNotes.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 20, left: 10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 209, 122, 51),
                      Color.fromARGB(255, 255, 235, 211),
                        Color.fromARGB(255, 235, 207, 188),
                        Color.fromARGB(255, 230, 153, 39),
                    ]),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ListTile(
                        onLongPress: () {
                          deleteNote(filteredNotes[index]);
                        },
                        title: Text(
                          filteredNotes[index].title,
                          style:const TextStyle(color: Colors.black, fontSize: 24),
                        ),
                        subtitle: Padding(
                          padding:
                              const EdgeInsets.only(top: 15, bottom: 15),
                          child: Text(
                            filteredNotes[index].description,
                            style: TextStyle(
                              color: Colors.black.withOpacity(.3),
                              fontSize: 18,
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () =>
                              editNote(context, filteredNotes[index]),
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create Note',
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: _addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
