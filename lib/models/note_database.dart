import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/models/note.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;
//initilize  the database
  static Future<void> initilize() async {
    final directory = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: directory.path,
    );
  }

  //list of notes
  final List<Note> currentNotes = [];

  //create a note and save to db
  Future<void> addNote(String titleFromUser, String contentFromUser) async {
    final newNote = Note()
      ..title = titleFromUser
      ..content = contentFromUser;

    //save to db
    await isar.writeTxn(() => isar.notes.put(newNote));

    //re-read from db
    fetchNotes();
  }

//read  all data from db
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }
  //update a note in db

  Future<void> updateNote(int id, String newTitle, String newContent) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.title = newTitle;
      existingNote.content = newContent;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  //delete a note from db
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    fetchNotes();
  }
}
