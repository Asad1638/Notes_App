import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/notes_model.dart';
import 'constant.dart';

class EditNotes extends StatefulWidget {
  NotesModel notes;

   EditNotes({
    Key? key,
    required this.notes,
  }) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  final TextEditingController _title = TextEditingController();

  final TextEditingController _content = TextEditingController();

  final myBox = Hive.box('Notes');
  @override
  void initState() {
    
    super.initState();
    print ("note received = ${widget.notes.title}");
    _title.text = widget.notes.title;
    _content.text = widget.notes.description;
  }

  void _updateNote(context) {

  widget.notes.title=_title.text;
  widget.notes.description = _content.text;
  widget.notes.save();
    
      Navigator.of(context).pop();
    }
  

  showToast(context, message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('E D I T  N O T E S'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => _updateNote(context),
              icon: const Icon(Icons.check)),
        ],
      ),
      body: Padding(
        padding:const  EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Column(
          children: [
            TextField(cursorColor:const Color(0xff262FCD7),
            
              controller: _title,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Title',
                  labelStyle:const TextStyle(color: kPrimaryColor),
                border: buildBorder(),
                focusedBorder: buildBorder(kPrimaryColor),
                enabledBorder: buildBorder(kPrimaryColor),
              ),
            ),
         const   SizedBox(
              height: 20,
            ),
            TextField(cursorColor: kPrimaryColor,
              controller: _content,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Content',
                labelStyle:const TextStyle(color: kPrimaryColor),
                border: borderBuild(),
                  focusedBorder: buildBorder(kPrimaryColor),
                enabledBorder: buildBorder(kPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder borderBuild([Color]) {
    return OutlineInputBorder(borderSide:const  BorderSide(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(15),
              );
  }

  OutlineInputBorder buildBorder([color]) {
    return OutlineInputBorder(borderSide:const  BorderSide(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(15),
              );
  }
}
