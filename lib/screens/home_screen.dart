import 'package:floopy_notes/provider/note_provider.dart';
import 'package:floopy_notes/resources/colors.dart';
import 'package:floopy_notes/screens/create_notes_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/notes.dart';
import '../resources/my_card.dart';

class HomePage extends StatefulWidget {
  final String? name;
  const HomePage({super.key, required this.name});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _showDeleteConfirmation(BuildContext context, Note notes) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Note'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      Provider.of<NoteProvider>(context, listen: false).deleteNote(notes);
    }
  }

  String searchQuery = '';

  List<Note> get filteredNotes {
    final noteProvider = Provider.of<NoteProvider>(context);
    final notes = noteProvider.notes;

    return notes.where((note) {
      final title = note.title.toLowerCase();
      final content = note.content.toLowerCase();
      final query = searchQuery.toLowerCase();
      return title.contains(query) || content.contains(query);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    getPreferences(widget.name);
  }

  void getPreferences(String? userName) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.getString('name');
  }

  final searchCTRL = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);

    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
            child: Column(
              children: [
                Center(
                  child: RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                      text: "Welcome! ",
                      style: TextStyle(
                          color: purple,
                          fontSize: 15,
                          fontFamily: 'Montserrat'),
                    ),
                    TextSpan(
                      text: widget.name!.toUpperCase(),
                      style: const TextStyle(
                          color: pink,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                  ])),
                ),
                SizedBox(
                  height: size.height * 0.005,
                ),
                TextFormField(
                  controller: searchCTRL,
                  cursorColor: purple,
                  decoration: InputDecoration(
                    hintText: "Search Notes",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      CupertinoIcons.search,
                      color: Colors.grey,
                    ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    constraints: const BoxConstraints(
                      maxHeight: 50,
                    ),
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          BorderSide(color: Colors.grey.shade400, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: pink, width: 2),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                      final noteProvider =
                          Provider.of<NoteProvider>(context, listen: false);
                      final filteredNotes = noteProvider.notes.where((note) {
                        final title = note.title.toLowerCase();
                        final content = note.content.toLowerCase();
                        final query = searchQuery.toLowerCase();
                        return title.contains(query) || content.contains(query);
                      }).toList();
                      noteProvider.setFilteredNotes(filteredNotes);
                    });
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                if (searchQuery.isNotEmpty && filteredNotes.isEmpty)
                  Center(
                    child: Text(
                      "No Record found or Try to correct spellings",
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade500),
                    ),
                  ),
                if (searchQuery.isEmpty || filteredNotes.isNotEmpty)
                  Expanded(
                    child: noteProvider.notes.isEmpty
                        ? Center(
                            child: Text(
                              "No note created",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey.shade500),
                            ),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8.0),
                            itemCount: filteredNotes.length,
                            itemBuilder: (context, index) {
                              final note = filteredNotes[index];
                              return MyCard(
                                  content: note.content,
                                  title: note.title.toUpperCase(),
                                  note: note,
                                  onLongPress: () =>
                                      _showDeleteConfirmation(context, note));
                            },
                          ),
                  ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CreateNotes()));
          },
          backgroundColor: purple,
          foregroundColor: cyan,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
