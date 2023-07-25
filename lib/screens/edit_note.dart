import 'package:floopy_notes/provider/note_provider.dart';
import 'package:floopy_notes/resources/colors.dart';
import 'package:floopy_notes/resources/current_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/notes.dart';

class EditNotes extends StatefulWidget {
  final Note note;
  const EditNotes({super.key, required this.note});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  late TextEditingController titleCTRL;
  late TextEditingController contentCTRL;
  final currentTime = getCurrentTime();
  @override
  void initState() {
    super.initState();
    titleCTRL = TextEditingController(text: widget.note.title);
    contentCTRL = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    titleCTRL.dispose();
    contentCTRL.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    return Scaffold(
      backgroundColor: purple.withOpacity(0.4),
      appBar: AppBar(
        title: Image.asset(
          "assets/floopy_notes_logo.png",
          height: 40,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {
                  final editedNote = Note(
                    title: titleCTRL.text,
                    content: contentCTRL.text,
                  );

                  noteProvider.editNote(widget.note, editedNote);

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
