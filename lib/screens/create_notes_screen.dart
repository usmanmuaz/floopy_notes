import 'package:floopy_notes/provider/note_provider.dart';
import 'package:floopy_notes/resources/colors.dart';
import 'package:floopy_notes/resources/current_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/notes.dart';

class CreateNotes extends StatefulWidget {
  const CreateNotes({super.key});

  @override
  State<CreateNotes> createState() => _CreateNotesState();
}

class _CreateNotesState extends State<CreateNotes> {
  final titleCTRL = TextEditingController();
  final contentCTRL = TextEditingController();
  final currentTime = getCurrentTime();

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);

    titleCTRL.text = 'Untitled';
    return Scaffold(
      backgroundColor: purple.withOpacity(0.4),
      appBar: AppBar(
        title: Image.asset(
          "assets/floopy_notes_logo.png",
          height: 40,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {
                  if (titleCTRL.text.trim().isEmpty ||
                      contentCTRL.text.trim().isEmpty) {
                    return;
                  }

                  final newNote = Note(
                    title: titleCTRL.text,
                    content: contentCTRL.text,
                  );
                  noteProvider.addNote(newNote);
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.save_as_outlined,
                  color: Colors.grey.shade100,
                ),
              ))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: titleCTRL,
                cursorColor: Colors.grey.shade100,
                minLines: 1,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.grey.shade100,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
                maxLength: 50,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(
                    CupertinoIcons.pen,
                    color: Colors.grey,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: TextFormField(
                    controller: contentCTRL,
                    cursorColor: Colors.grey.shade100,
                    style: TextStyle(
                      color: Colors.grey.shade100,
                    ),
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: "Note something down",
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 5)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
