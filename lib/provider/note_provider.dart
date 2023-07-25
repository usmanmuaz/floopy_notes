import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/notes.dart';

class NoteProvider extends ChangeNotifier {
  final String _notesKey = 'notes';
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> fetchNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getString(_notesKey);
    if (notesJson != null) {
      _notes = (json.decode(notesJson) as List)
          .map((noteJson) => Note.fromJson(noteJson))
          .toList();
    }
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    _notes.add(note);
    await _saveNotes();
  }

  Future<void> deleteNote(Note note) async {
    _notes.remove(note);
    await _saveNotes();
    notifyListeners();
  }

  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = json.encode(_notes.map((note) => note.toJson()).toList());
    await prefs.setString(_notesKey, notesJson);
    notifyListeners();
  }

  List<Note> _filteredNotes = [];

  List<Note> get filteredNotes => _filteredNotes;

  setFilteredNotes(List<Note> notes) {
    _filteredNotes = notes;
    notifyListeners();
  }

  void editNote(Note oldNote, Note newNote) {
    final index = _notes.indexOf(oldNote);
    if (index != -1) {
      _notes[index] = newNote;
      _saveNotes();
    }
  }
}
