import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/note.dart';
import 'package:weather_app/models/note_database.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
//text controller to access what the user typed

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //on app startup we can watch existing notes
    readNotes();
  }

//create a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.createNote),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.noteTitle),
              controller: titleController,
            ),
            const SizedBox(height: 10),
            TextField(
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.noteContent),
                controller: contentController),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); //close dialog box
            },
            child: Text(AppLocalizations.of(context)!.cancelNote),
          ),
          ElevatedButton(
            onPressed: () {
              context
                  .read<NoteDatabase>()
                  .addNote(titleController.text, contentController.text);

              //clear contrloller
              titleController.clear();
              contentController.clear();
              //pop dialog box
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context)!.submitNote),
          )
        ],
      ),
    );
  }

//read notes
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

//update a note
  void updateNote(Note note) {
    titleController.text = note.title;
    contentController.text = note.content;
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Update Note"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.noteTitle),
              controller: titleController,
            ),
            const SizedBox(height: 10),
            TextField(
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.noteContent),
                controller: contentController),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              //clear contrloller
              titleController.clear();
              contentController.clear();
              Navigator.of(context).pop(); //close dialog box
            },
            child: Text(AppLocalizations.of(context)!.cancelNote),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<NoteDatabase>().updateNote(
                  note.id, titleController.text, contentController.text);

              //clear contrloller
              titleController.clear();
              contentController.clear();
              //pop dialog box
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context)!.submitNote),
          )
        ],
      ),
    );
  }

//delete a note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    // note darabase

    final noteDatabase = context.watch<NoteDatabase>();

    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNote();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADING
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              AppLocalizations.of(context)!.notes,
              style: GoogleFonts.bebasNeue(fontSize: 48),
            ),
          ),

          // LIST OF NOTES
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                // get individual note
                final note = currentNotes[index];
                //list tile UI
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //edit button
                      IconButton(
                        icon: const Icon(Icons.edit),
                        tooltip: 'Edit Note',
                        onPressed: () => updateNote(note),
                      ),
                      //delete button
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        tooltip: 'Delete Note',
                        onPressed: () => deleteNote(note.id),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
