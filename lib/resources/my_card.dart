import 'package:floopy_notes/models/notes.dart';
import 'package:floopy_notes/resources/colors.dart';
import 'package:floopy_notes/screens/edit_note.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String title;
  final String content;
  final Note note;
  final VoidCallback onLongPress;
  const MyCard(
      {super.key,
      required this.title,
      required this.content,
      required this.onLongPress,
      required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditNotes(
                      note: note,
                    )));
      },
      child: Container(
        height: 175,
        width: 175,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.5),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: purple,
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                content,
                style: const TextStyle(
                  color: blue,
                  fontFamily: 'Montserrat',
                  fontSize: 10,
                ),
                maxLines: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
